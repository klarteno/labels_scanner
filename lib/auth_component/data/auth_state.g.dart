// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthStateCWProxy {
  AuthState authStatus(AuthStatus authStatus);

  AuthState credentials(Credentials? credentials);

  AuthState loginStatus(AuthRequestStatus loginStatus);

  AuthState sessionId(String? sessionId);

  AuthState signUpStatus(AuthRequestStatus signUpStatus);

  AuthState userId(String? userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    AuthStatus? authStatus,
    Credentials? credentials,
    AuthRequestStatus? loginStatus,
    String? sessionId,
    AuthRequestStatus? signUpStatus,
    String? userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthState.copyWith.fieldName(...)`
class _$AuthStateCWProxyImpl implements _$AuthStateCWProxy {
  final AuthState _value;

  const _$AuthStateCWProxyImpl(this._value);

  @override
  AuthState authStatus(AuthStatus authStatus) => this(authStatus: authStatus);

  @override
  AuthState credentials(Credentials? credentials) =>
      this(credentials: credentials);

  @override
  AuthState loginStatus(AuthRequestStatus loginStatus) =>
      this(loginStatus: loginStatus);

  @override
  AuthState sessionId(String? sessionId) => this(sessionId: sessionId);

  @override
  AuthState signUpStatus(AuthRequestStatus signUpStatus) =>
      this(signUpStatus: signUpStatus);

  @override
  AuthState userId(String? userId) => this(userId: userId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthState call({
    Object? authStatus = const $CopyWithPlaceholder(),
    Object? credentials = const $CopyWithPlaceholder(),
    Object? loginStatus = const $CopyWithPlaceholder(),
    Object? sessionId = const $CopyWithPlaceholder(),
    Object? signUpStatus = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return AuthState(
      authStatus:
          authStatus == const $CopyWithPlaceholder() || authStatus == null
              ? _value.authStatus
              // ignore: cast_nullable_to_non_nullable
              : authStatus as AuthStatus,
      credentials: credentials == const $CopyWithPlaceholder()
          ? _value.credentials
          // ignore: cast_nullable_to_non_nullable
          : credentials as Credentials?,
      loginStatus:
          loginStatus == const $CopyWithPlaceholder() || loginStatus == null
              ? _value.loginStatus
              // ignore: cast_nullable_to_non_nullable
              : loginStatus as AuthRequestStatus,
      sessionId: sessionId == const $CopyWithPlaceholder()
          ? _value.sessionId
          // ignore: cast_nullable_to_non_nullable
          : sessionId as String?,
      signUpStatus:
          signUpStatus == const $CopyWithPlaceholder() || signUpStatus == null
              ? _value.signUpStatus
              // ignore: cast_nullable_to_non_nullable
              : signUpStatus as AuthRequestStatus,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $AuthStateCopyWith on AuthState {
  /// Returns a callable class that can be used as follows: `instanceOfclass AuthState.name.copyWith(...)` or like so:`instanceOfclass AuthState.name.copyWith.fieldName(...)`.
  _$AuthStateCWProxy get copyWith => _$AuthStateCWProxyImpl(this);
}
