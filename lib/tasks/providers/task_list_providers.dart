import 'package:labels_scanner/auth_component/providers/auth_providers.dart';
import 'package:labels_scanner/tasks/data/task_editing_state.dart';
import 'package:labels_scanner/tasks/data/tasks_list_state.dart';
import 'package:labels_scanner/tasks/notifier/task_editing_notifier.dart';
import 'package:labels_scanner/tasks/notifier/task_list_notifier.dart';
import 'package:labels_scanner/models/classes/task.dart';
import 'package:labels_scanner/services/tasks/tasks_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service

final _tasksServiceProvider =
    Provider.autoDispose<ITasksService>((ref) => TasksService(ref.read));

// Task List Page

final tasksListStateProvider =
    StateNotifierProvider.autoDispose<TaskListNotifier, TaskListState>((ref) {
  final String? userId = ref.read(userIdProvider);
  return TaskListNotifier(
      service: ref.watch(_tasksServiceProvider), userId: userId);
});

final tasksListProvider = Provider.autoDispose<List<Task>>(
    (ref) => ref.watch(tasksListStateProvider).tasks);

// Task Editing Page

final taskEditingProviderFamily = StateNotifierProvider.autoDispose
    .family<TaskEditingNotifier, TaskEditingState, Task?>((ref, editedTask) =>
        TaskEditingNotifier(
            initialTask: editedTask,
            service: ref.watch(_tasksServiceProvider)));
