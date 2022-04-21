import 'package:flutter/material.dart';
import 'components/sign_up_screen_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpScreenWidget(),
    );
  }
}
