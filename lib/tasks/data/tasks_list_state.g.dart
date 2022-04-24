// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskListStateCWProxy {
  TaskListState status(TaskListStatus status);

  TaskListState tasks(List<Task> tasks);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskListState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskListState call({
    TaskListStatus? status,
    List<Task>? tasks,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskListState.copyWith.fieldName(...)`
class _$TaskListStateCWProxyImpl implements _$TaskListStateCWProxy {
  final TaskListState _value;

  const _$TaskListStateCWProxyImpl(this._value);

  @override
  TaskListState status(TaskListStatus status) => this(status: status);

  @override
  TaskListState tasks(List<Task> tasks) => this(tasks: tasks);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskListState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskListState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? tasks = const $CopyWithPlaceholder(),
  }) {
    return TaskListState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as TaskListStatus,
      tasks: tasks == const $CopyWithPlaceholder() || tasks == null
          ? _value.tasks
          // ignore: cast_nullable_to_non_nullable
          : tasks as List<Task>,
    );
  }
}

extension $TaskListStateCopyWith on TaskListState {
  /// Returns a callable class that can be used as follows: `instanceOfclass TaskListState.name.copyWith(...)` or like so:`instanceOfclass TaskListState.name.copyWith.fieldName(...)`.
  _$TaskListStateCWProxy get copyWith => _$TaskListStateCWProxyImpl(this);
}
