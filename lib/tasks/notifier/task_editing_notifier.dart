import 'package:labels_scanner/tasks/data/task_editing_state.dart';
import 'package:labels_scanner/models/classes/task.dart';
import 'package:labels_scanner/models/enums/task_priority.dart';
import 'package:labels_scanner/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums/task_priority.dart';
import '../data/task_editing_state.dart';

class TaskEditingNotifier extends StateNotifier<TaskEditingState> {
  TaskEditingNotifier({required ITasksService service, Task? initialTask})
      : _service = service,
        super((initialTask != null)
            ? TaskEditingState.edit(initialTask)
            : TaskEditingState.create());

  final ITasksService _service;

  //
  // User Actions
  //

  void registerSelectedPriority(TaskPriority priority) {
    state = state.copyWith(task: state.task.copyWith(priority: priority));
  }

  void registerSelectedReminderDate(DateTime date) {
    state = state.copyWith(task: state.task.copyWith(reminderDate: date));
  }

  //
  // Service Actions
  //

  Future<void> saveTask(String title, String? text) async {
    state = state.copyWith(saveStatus: TaskEditingStatus.loading);

    Task task = state.task;
    task.title = title;
    task.text = text;
    task.date ??= DateTime.now();

    try {
      if (task.id == null) {
        await _service.addTask(task);
      } else {
        await _service.updateTask(task);
      }
      state = state.copyWith(saveStatus: TaskEditingStatus.success);
    } catch (e) {
      state = state.copyWith(saveStatus: TaskEditingStatus.failed);
      rethrow;
    }
  }

  Future<void> deleteTask() async {
    state = state.copyWith(deleteStatus: TaskEditingStatus.loading);

    try {
      await _service.deleteTask(state.task);
      state = state.copyWith(deleteStatus: TaskEditingStatus.success);
    } catch (e) {
      state = state.copyWith(deleteStatus: TaskEditingStatus.failed);
      rethrow;
    }
  }
}
