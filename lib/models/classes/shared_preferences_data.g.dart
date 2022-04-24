// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SharedPreferencesDataCWProxy {
  SharedPreferencesData activeAccountSessionId(String? activeAccountSessionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SharedPreferencesData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SharedPreferencesData(...).copyWith(id: 12, name: "My name")
  /// ````
  SharedPreferencesData call({
    String? activeAccountSessionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSharedPreferencesData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSharedPreferencesData.copyWith.fieldName(...)`
class _$SharedPreferencesDataCWProxyImpl
    implements _$SharedPreferencesDataCWProxy {
  final SharedPreferencesData _value;

  const _$SharedPreferencesDataCWProxyImpl(this._value);

  @override
  SharedPreferencesData activeAccountSessionId(
          String? activeAccountSessionId) =>
      this(activeAccountSessionId: activeAccountSessionId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SharedPreferencesData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SharedPreferencesData(...).copyWith(id: 12, name: "My name")
  /// ````
  SharedPreferencesData call({
    Object? activeAccountSessionId = const $CopyWithPlaceholder(),
  }) {
    return SharedPreferencesData(
      activeAccountSessionId:
          activeAccountSessionId == const $CopyWithPlaceholder()
              ? _value.activeAccountSessionId
              // ignore: cast_nullable_to_non_nullable
              : activeAccountSessionId as String?,
    );
  }
}

extension $SharedPreferencesDataCopyWith on SharedPreferencesData {
  /// Returns a callable class that can be used as follows: `instanceOfclass SharedPreferencesData.name.copyWith(...)` or like so:`instanceOfclass SharedPreferencesData.name.copyWith.fieldName(...)`.
  _$SharedPreferencesDataCWProxy get copyWith =>
      _$SharedPreferencesDataCWProxyImpl(this);
}
