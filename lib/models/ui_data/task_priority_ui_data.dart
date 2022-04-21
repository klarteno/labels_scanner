import 'package:labels_scanner/models/enums/task_priority.dart';
import 'package:flutter/material.dart';

class TaskPriorityUiElements {
  final String title;
  final Color color;

  const TaskPriorityUiElements._(this.title, this.color);

  factory TaskPriorityUiElements.priority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.normal:
        return _normal;
      case TaskPriority.warning:
        return _warning;
      case TaskPriority.important:
        return _important;
      case TaskPriority.urgent:
        return _urgent;
    }
  }

  static const TaskPriorityUiElements _normal =
      TaskPriorityUiElements._("Normal", Colors.blue);
  static const TaskPriorityUiElements _warning =
      TaskPriorityUiElements._("Warning", Colors.lime);
  static const TaskPriorityUiElements _important =
      TaskPriorityUiElements._("Important", Colors.redAccent);
  static const TaskPriorityUiElements _urgent =
      TaskPriorityUiElements._("Urgent", Colors.purple);
}
