import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:labels_scanner/tasks/data/tasks_list_state.dart';
import 'package:labels_scanner/models/classes/task.dart';
import 'package:labels_scanner/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListNotifier extends StateNotifier<TaskListState> {
  TaskListNotifier({required ITasksService service, required String? userId})
      : _service = service,
        _userId = userId,
        super(TaskListState.initial()) {
    _getTasksStream();
  }

  final ITasksService _service;
  final String? _userId;

  StreamSubscription<RealtimeMessage>? tasksStreamSubscription;

  @override
  void dispose() {
    tasksStreamSubscription?.cancel();
    super.dispose();
  }

  //
  // Stream
  //

  void _getTasksStream() {
    tasksStreamSubscription =
        _service.getTasksStream().listen(_handleTaskStreamUpdate);
  }

  void _handleTaskStreamUpdate(RealtimeMessage message) {
    print(message);

    // TODO: is there a way to only get documents from the collection created by the user ?
    // The created documents are setup by default with a permission to be read
    // or written only by the creator. Thus, by design only the events the
    // current user is permitted to receive are sent.
    // While it is convenient here, how to implement a messaging sys, ...

    if (message.event == "database.documents.update") {
      Task modifiedTask = Task.fromAppWrite(message.payload);
      List<Task> tasks = state.tasks;
      tasks.map((task) {
        if (task.id == modifiedTask.id) return modifiedTask;
        return task;
      });
      state = state.copyWith(tasks: tasks);
    } else if (message.event == "database.documents.create") {
      Task newTask = Task.fromAppWrite(message.payload);
      state = state.copyWith(tasks: state.tasks..add(newTask));
    } else if (message.event == "database.documents.delete") {
      String deletedTaskId = message.payload["\$id"];
      state = state.copyWith(
          tasks: state.tasks..removeWhere((task) => task.id == deletedTaskId));
    }
  }

  //
  // Tasks
  //

  Future<void> toggleTask(String id, bool selected) async {
    // Internal update
    Task modifiedTask = state.tasks.firstWhere((task) => task.id == id);

    modifiedTask.done = selected;
    modifiedTask.doneDate = (selected) ? DateTime.now() : null;

    await _service.updateTask(modifiedTask);

    // Implement AppWrite
  }

  Future<void> deleteTask(Task task) async {}

  Future<void> getTasks() async {
    state = state.copyWith(status: TaskListStatus.loading);
    try {
      await _service.getTasks().then((List<Task> tasks) {
        state = state.copyWith(tasks: tasks, status: TaskListStatus.loaded);
      });
    } catch (e) {
      state = state.copyWith(status: TaskListStatus.failed);
      rethrow;
      // Error handling to set up
    }
  }
}
