import 'package:labels_scanner/auth_component/data/auth_state.dart';
import 'package:labels_scanner/auth_component/notifier/auth_notifier.dart';
import 'package:labels_scanner/services/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service Provider
final _authServiceProvider =
    Provider.autoDispose<IAuthService>((ref) => AuthService(ref.read));

// StateNotifier
final authStateProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
        (ref) => AuthNotifier(service: ref.watch(_authServiceProvider)));

// User Id Provider
final userIdProvider = Provider.autoDispose<String?>(
    (ref) => ref.watch(authStateProvider.select((state) => state.userId)));
