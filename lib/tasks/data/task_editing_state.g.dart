// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_editing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaskEditingStateCWProxy {
  TaskEditingState deleteStatus(TaskEditingStatus deleteStatus);

  TaskEditingState saveStatus(TaskEditingStatus saveStatus);

  TaskEditingState task(Task task);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskEditingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskEditingState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskEditingState call({
    TaskEditingStatus? deleteStatus,
    TaskEditingStatus? saveStatus,
    Task? task,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaskEditingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaskEditingState.copyWith.fieldName(...)`
class _$TaskEditingStateCWProxyImpl implements _$TaskEditingStateCWProxy {
  final TaskEditingState _value;

  const _$TaskEditingStateCWProxyImpl(this._value);

  @override
  TaskEditingState deleteStatus(TaskEditingStatus deleteStatus) =>
      this(deleteStatus: deleteStatus);

  @override
  TaskEditingState saveStatus(TaskEditingStatus saveStatus) =>
      this(saveStatus: saveStatus);

  @override
  TaskEditingState task(Task task) => this(task: task);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaskEditingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaskEditingState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaskEditingState call({
    Object? deleteStatus = const $CopyWithPlaceholder(),
    Object? saveStatus = const $CopyWithPlaceholder(),
    Object? task = const $CopyWithPlaceholder(),
  }) {
    return TaskEditingState(
      deleteStatus:
          deleteStatus == const $CopyWithPlaceholder() || deleteStatus == null
              ? _value.deleteStatus
              // ignore: cast_nullable_to_non_nullable
              : deleteStatus as TaskEditingStatus,
      saveStatus:
          saveStatus == const $CopyWithPlaceholder() || saveStatus == null
              ? _value.saveStatus
              // ignore: cast_nullable_to_non_nullable
              : saveStatus as TaskEditingStatus,
      task: task == const $CopyWithPlaceholder() || task == null
          ? _value.task
          // ignore: cast_nullable_to_non_nullable
          : task as Task,
    );
  }
}

extension $TaskEditingStateCopyWith on TaskEditingState {
  /// Returns a callable class that can be used as follows: `instanceOfclass TaskEditingState.name.copyWith(...)` or like so:`instanceOfclass TaskEditingState.name.copyWith.fieldName(...)`.
  _$TaskEditingStateCWProxy get copyWith => _$TaskEditingStateCWProxyImpl(this);
}
