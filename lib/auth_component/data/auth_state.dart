import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_state.g.dart';

@CopyWith()
class AuthState {
  Credentials? credentials;
  AuthStatus authStatus;
  AuthRequestStatus loginStatus;
  AuthRequestStatus signUpStatus;
  String? sessionId;
  String? userId;

  AuthState(
      {this.credentials,
      this.authStatus = AuthStatus.initialize,
      this.loginStatus = AuthRequestStatus.initialize,
      this.signUpStatus = AuthRequestStatus.initialize,
      this.sessionId,
      this.userId});

  factory AuthState.initial() => AuthState();
}

enum AuthStatus { initialize, authenticated, unauthenticated }

enum AuthRequestStatus { initialize, loading, success, failed, nonExistent }

class Credentials {
  String email;
  String password;

  Credentials(this.email, this.password);
}
