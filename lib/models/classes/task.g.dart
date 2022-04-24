// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskCWProxy {
  Task date(DateTime? date);

  Task done(bool done);

  Task doneDate(DateTime? doneDate);

  Task id(String? id);

  Task priority(TaskPriority priority);

  Task reminderDate(DateTime? reminderDate);

  Task text(String? text);

  Task title(String? title);

  Task userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Task(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Task(...).copyWith(id: 12, name: "My name")
  /// ````
  Task call({
    DateTime? date,
    bool? done,
    DateTime? doneDate,
    String? id,
    TaskPriority? priority,
    DateTime? reminderDate,
    String? text,
    String? title,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTask.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTask.copyWith.fieldName(...)`
class _$TaskCWProxyImpl implements _$TaskCWProxy {
  final Task _value;

  const _$TaskCWProxyImpl(this._value);

  @override
  Task date(DateTime? date) => this(date: date);

  @override
  Task done(bool done) => this(done: done);

  @override
  Task doneDate(DateTime? doneDate) => this(doneDate: doneDate);

  @override
  Task id(String? id) => this(id: id);

  @override
  Task priority(TaskPriority priority) => this(priority: priority);

  @override
  Task reminderDate(DateTime? reminderDate) => this(reminderDate: reminderDate);

  @override
  Task text(String? text) => this(text: text);

  @override
  Task title(String? title) => this(title: title);

  @override
  Task userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Task(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Task(...).copyWith(id: 12, name: "My name")
  /// ````
  Task call({
    Object? date = const $CopyWithPlaceholder(),
    Object? done = const $CopyWithPlaceholder(),
    Object? doneDate = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? reminderDate = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return Task(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      done: done == const $CopyWithPlaceholder() || done == null
          ? _value.done
          // ignore: cast_nullable_to_non_nullable
          : done as bool,
      doneDate: doneDate == const $CopyWithPlaceholder()
          ? _value.doneDate
          // ignore: cast_nullable_to_non_nullable
          : doneDate as DateTime?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      priority: priority == const $CopyWithPlaceholder() || priority == null
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as TaskPriority,
      reminderDate: reminderDate == const $CopyWithPlaceholder()
          ? _value.reminderDate
          // ignore: cast_nullable_to_non_nullable
          : reminderDate as DateTime?,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $TaskCopyWith on Task {
  /// Returns a callable class that can be used as follows: `instanceOfclass Task.name.copyWith(...)` or like so:`instanceOfclass Task.name.copyWith.fieldName(...)`.
  _$TaskCWProxy get copyWith => _$TaskCWProxyImpl(this);
}
