// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'barcodes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BarcodesDetails {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BarcodesDetailsCopyWith<BarcodesDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodesDetailsCopyWith<$Res> {
  factory $BarcodesDetailsCopyWith(
          BarcodesDetails value, $Res Function(BarcodesDetails) then) =
      _$BarcodesDetailsCopyWithImpl<$Res>;
  $Res call({String firstName, String lastName, int age});
}

/// @nodoc
class _$BarcodesDetailsCopyWithImpl<$Res>
    implements $BarcodesDetailsCopyWith<$Res> {
  _$BarcodesDetailsCopyWithImpl(this._value, this._then);

  final BarcodesDetails _value;
  // ignore: unused_field
  final $Res Function(BarcodesDetails) _then;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$BarcodesDetailsCopyWith<$Res>
    implements $BarcodesDetailsCopyWith<$Res> {
  factory _$BarcodesDetailsCopyWith(
          _BarcodesDetails value, $Res Function(_BarcodesDetails) then) =
      __$BarcodesDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String firstName, String lastName, int age});
}

/// @nodoc
class __$BarcodesDetailsCopyWithImpl<$Res>
    extends _$BarcodesDetailsCopyWithImpl<$Res>
    implements _$BarcodesDetailsCopyWith<$Res> {
  __$BarcodesDetailsCopyWithImpl(
      _BarcodesDetails _value, $Res Function(_BarcodesDetails) _then)
      : super(_value, (v) => _then(v as _BarcodesDetails));

  @override
  _BarcodesDetails get _value => super._value as _BarcodesDetails;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? age = freezed,
  }) {
    return _then(_BarcodesDetails(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_BarcodesDetails implements _BarcodesDetails {
  const _$_BarcodesDetails(
      {required this.firstName, required this.lastName, required this.age});

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final int age;

  @override
  String toString() {
    return 'BarcodesDetails(firstName: $firstName, lastName: $lastName, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BarcodesDetails &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.age, age));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(age));

  @JsonKey(ignore: true)
  @override
  _$BarcodesDetailsCopyWith<_BarcodesDetails> get copyWith =>
      __$BarcodesDetailsCopyWithImpl<_BarcodesDetails>(this, _$identity);
}

abstract class _BarcodesDetails implements BarcodesDetails {
  const factory _BarcodesDetails(
      {required final String firstName,
      required final String lastName,
      required final int age}) = _$_BarcodesDetails;

  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  int get age => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BarcodesDetailsCopyWith<_BarcodesDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
