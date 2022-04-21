import 'package:labels_scanner/models/classes/task.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'tasks_list_state.g.dart';

@CopyWith()
class TaskListState {
  final List<Task> tasks;
  final TaskListStatus status;

  TaskListState({required this.tasks, required this.status});

  factory TaskListState.initial() =>
      TaskListState(tasks: [], status: TaskListStatus.initial);
}

enum TaskListStatus { initial, loading, loaded, failed }
