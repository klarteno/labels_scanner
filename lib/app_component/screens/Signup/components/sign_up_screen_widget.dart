import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labels_scanner/app_component/screens/Login/login_screen.dart';
import 'package:labels_scanner/app_component/screens/Signup/components/background.dart';
import 'package:labels_scanner/app_component/screens/Signup/components/or_divider.dart';
import 'package:labels_scanner/app_component/screens/Signup/components/social_icon.dart';
import 'package:labels_scanner/app_component/screens/components/already_have_an_account_check.dart';
import 'package:labels_scanner/app_component/screens/components/rounded_input_field.dart';
import 'package:labels_scanner/app_component/screens/components/rounded_password_field.dart';

import '../../../app_home.dart';
import '../../../auth_component/data/auth_state.dart';
import '../../../auth_component/providers/auth_providers.dart';

class SignUpScreenWidget extends ConsumerStatefulWidget {
  const SignUpScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpScreenWidget> {
  Future<void> _signUp() async {
    final name = _userNameController.text;
    final String email = _emailIdController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Please enter your email and password'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));

      return;
    }

    await ref
        .read(authStateProvider.notifier)
        .signUp(name: name, email: email, password: password);

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AppHome()));
    }
  }

  late TextEditingController _userNameController;
  late TextEditingController _emailIdController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthRequestStatus signUpStatus =
        ref.watch(authStateProvider).signUpStatus;

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/signup.svg',
              height: size.height * 0.3,
            ),
            RoundedInputField(
              hintText: 'Your Name',
              icon: Icons.person,
              onChanged: (value) {},
              controller: _userNameController,
            ),
            RoundedInputField(
              hintText: 'Your Email',
              icon: Icons.email,
              onChanged: (value) {},
              controller: _emailIdController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controller: _passwordController,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.teal),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blue.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.blue.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  enableFeedback: true,
                  alignment: Alignment.center,
                  elevation: MaterialStateProperty.all(20),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontFamily: "alex")),
                  //padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                  //  vertical: 20, horizontal: 140)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 120)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                ),
                onPressed: _signUp,
                child: (signUpStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up")),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: 'assets/icons/facebook.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/twitter.svg',
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: 'assets/icons/google-plus.svg',
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
