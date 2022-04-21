import 'package:labels_scanner/auth_component/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_component/screens/Welcome/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: WelcomeScreen()));
}
//WelcomeScreen
