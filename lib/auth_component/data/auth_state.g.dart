// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AuthStateCopyWith on AuthState {
  AuthState copyWith({
    AuthStatus? authStatus,
    Credentials? credentials,
    AuthRequestStatus? loginStatus,
    String? sessionId,
    AuthRequestStatus? signUpStatus,
    String? userId,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      credentials: credentials ?? this.credentials,
      loginStatus: loginStatus ?? this.loginStatus,
      sessionId: sessionId ?? this.sessionId,
      signUpStatus: signUpStatus ?? this.signUpStatus,
      userId: userId ?? this.userId,
    );
  }
}
