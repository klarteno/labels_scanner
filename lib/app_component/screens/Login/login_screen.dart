import 'package:flutter/material.dart';

import 'components/login_screen_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreenWidget(),
    );
  }
}
