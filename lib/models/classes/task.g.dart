// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TaskCopyWith on Task {
  Task copyWith({
    DateTime? date,
    bool? done,
    DateTime? doneDate,
    String? id,
    TaskPriority? priority,
    DateTime? reminderDate,
    String? text,
    String? title,
    String? userId,
  }) {
    return Task(
      date: date ?? this.date,
      done: done ?? this.done,
      doneDate: doneDate ?? this.doneDate,
      id: id ?? this.id,
      priority: priority ?? this.priority,
      reminderDate: reminderDate ?? this.reminderDate,
      text: text ?? this.text,
      title: title ?? this.title,
      userId: userId ?? this.userId,
    );
  }
}
