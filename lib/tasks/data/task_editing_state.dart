import 'package:labels_scanner/models/classes/task.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'task_editing_state.g.dart';

@CopyWith()
class TaskEditingState {
  Task task;
  TaskEditingStatus saveStatus;
  TaskEditingStatus deleteStatus;

  TaskEditingState(
      {required this.task,
      this.saveStatus = TaskEditingStatus.initial,
      this.deleteStatus = TaskEditingStatus.initial});

  factory TaskEditingState.edit(Task task) => TaskEditingState(task: task);
  factory TaskEditingState.create() => TaskEditingState(task: Task.empty());
}

enum TaskEditingStatus { initial, loading, success, failed }
