import 'package:labels_scanner/models/enums/task_priority.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'task.g.dart';

@CopyWith()
class Task {
  String? id;
  String? title;
  String? text;
  String? userId;
  late bool done;
  late TaskPriority priority;
  DateTime? date;
  DateTime? reminderDate;
  DateTime? doneDate;

  Task(
      {this.id,
      this.title,
      this.text,
      this.userId,
      this.done = false,
      this.priority = TaskPriority.normal,
      this.date,
      this.reminderDate,
      this.doneDate});

  factory Task.empty() => Task();

  Task.fromAppWrite(Map<String, dynamic> map) {
    id = map[_TaskMapKeys.idKey];
    title = map[_TaskMapKeys.titleKey];
    text = map[_TaskMapKeys.textKey];
    userId = map[_TaskMapKeys.userIdKey];
    done = map[_TaskMapKeys.doneKey];
    priority = TaskPriority.values[map[_TaskMapKeys.priorityKey]];
    if (map[_TaskMapKeys.dateKey] != null) {
      date = DateTime.fromMillisecondsSinceEpoch(map[_TaskMapKeys.dateKey]);
    }
    if (map[_TaskMapKeys.reminderDateKey] != null) {
      reminderDate = DateTime.fromMillisecondsSinceEpoch(
          map[_TaskMapKeys.reminderDateKey]);
    }
    if (map[_TaskMapKeys.doneDateKey] != null) {
      doneDate =
          DateTime.fromMillisecondsSinceEpoch(map[_TaskMapKeys.doneDateKey]);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      _TaskMapKeys.titleKey: title,
      _TaskMapKeys.textKey: text,
      _TaskMapKeys.userIdKey: userId,
      _TaskMapKeys.doneKey: done,
      _TaskMapKeys.priorityKey: priority.index,
      _TaskMapKeys.dateKey: date?.millisecondsSinceEpoch,
      _TaskMapKeys.reminderDateKey: reminderDate?.millisecondsSinceEpoch,
      _TaskMapKeys.doneDateKey: doneDate?.millisecondsSinceEpoch
    };
  }
}

class _TaskMapKeys {
  static const String idKey = "\$id";
  static const String titleKey = "title";
  static const String textKey = "text";
  static const String userIdKey = "userId";
  static const String doneKey = "done";
  static const String priorityKey = "priority";
  static const String dateKey = "date";
  static const String reminderDateKey = "reminderDate";
  static const String doneDateKey = "doneDate";
}
