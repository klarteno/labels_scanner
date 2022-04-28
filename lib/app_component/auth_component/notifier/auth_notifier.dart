import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/app_component/auth_component/data/auth_state.dart';
import 'package:labels_scanner/services/auth/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required IAuthService service})
      : _service = service,
        super(AuthState.initial());

  final IAuthService _service;

  //
  // Auth
  //

  Future<void> getActiveSession() async {
    state = state.copyWith(loginStatus: AuthRequestStatus.loading);
    try {
      final Session? activeSession = await _service.getActiveSession();
      if (activeSession == null) {
        state = state.copyWith(
            loginStatus: AuthRequestStatus.failed,
            authStatus: AuthStatus.unauthenticated);
      } else {
        state = state.copyWith(
            loginStatus: AuthRequestStatus.success,
            authStatus: AuthStatus.authenticated,
            sessionId: activeSession.$id,
            userId: activeSession.userId);
      }
    } catch (e) {
      state = state.copyWith(loginStatus: AuthRequestStatus.failed);
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(loginStatus: AuthRequestStatus.loading);
    try {
      final Session session =
          await _service.createAccountSession(email, password);
      state = state.copyWith(
          loginStatus: AuthRequestStatus.success,
          authStatus: AuthStatus.authenticated,
          sessionId: session.$id,
          userId: session.userId);
    } catch (e) {
      state = state.copyWith(loginStatus: AuthRequestStatus.nonExistent);
      rethrow;
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    state = state.copyWith(signUpStatus: AuthRequestStatus.loading);
    try {
      final User user =
          await _service.signUp(name: name, email: email, password: password);
      final Session session =
          await _service.createAccountSession(email, password);
      state = state.copyWith(
          signUpStatus: AuthRequestStatus.success,
          authStatus: AuthStatus.authenticated,
          sessionId: session.$id,
          userId: session.userId);
    } catch (e) {
      state = state.copyWith(signUpStatus: AuthRequestStatus.failed);
      rethrow;
      // Error handling to set up
    }
  }
}
