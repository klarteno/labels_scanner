import 'package:appwrite/models.dart';
import 'package:labels_scanner/general_providers/shared_preferences_provider.dart';
import 'package:labels_scanner/services/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IAuthService {
  Future<Session?> getActiveSession();
  Future<User> signUp(
      {required String name, required String email, required String password});
  Future<Session> createAccountSession(String email, String password);
}

class AuthService implements IAuthService {
  final Reader _read;

  AuthService(this._read);

  /// Create a Session for a user with an existing account (serves as a login
  /// if the previous session has expired).
  ///
  /// The  [Session.$id] is stored by the service to retrieve the current
  /// active session on the next lifecycles of the app without loging in
  /// again.
  ///
  /// This id is stored in SharedPreferences.
  ///
  /// If null is returned, a new [Session] should be created by calling
  /// [createAccountSession].
  ///
  /// If the process fails, the method will throw.
  @override
  Future<Session?> getActiveSession() async {
    final String? sessionId =
        _read(sharedPrefsDataProvider)?.activeAccountSessionId;
    if (sessionId == null) return null;
    final Session session =
        await _read(appwriteAccountProvider).getSession(sessionId: sessionId);
    // Optional since the session will be the same
    _read(sharedPrefsDataProvider.notifier).setCurrentSessionId(session.$id);
    return session;
  }

  /// Creates a new Session replacing any preexisting one. It's an explicit
  /// login function for existing users and newly created users with [signUp].
  ///
  /// If the process fails, the method will throw.
  @override
  Future<Session> createAccountSession(String email, String password) async {
    final Session session = await _read(appwriteAccountProvider)
        .createSession(email: email, password: password);
    _read(sharedPrefsDataProvider.notifier).setCurrentSessionId(session.$id);
    return session;
  }

  /// Creates a new User with the given credentials.
  ///
  /// The User will not have an active [Session] at this point. Once created,
  /// [createAccountSession] should be called to login the newly created user
  /// and setup an active session.
  ///
  /// If the process fails, the method will throw.
  @override
  Future<User> signUp(
      {required String name,
      required String email,
      required String password}) async {
    return await _read(appwriteAccountProvider).create(
      userId: 'unique()',
      name: name,
      email: email,
      password: password,
    );
  }
}
