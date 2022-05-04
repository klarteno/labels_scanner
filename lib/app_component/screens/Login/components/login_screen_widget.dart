import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labels_scanner/app_component/app_tabs_components/app_tabs_home.dart';
import 'package:labels_scanner/app_component/screens/Signup/signup_screen.dart';
import 'package:labels_scanner/app_component/screens/components/already_have_an_account_check.dart';
import 'package:labels_scanner/app_component/screens/components/rounded_input_field.dart';
import 'package:labels_scanner/app_component/screens/components/rounded_password_field.dart';
import 'package:labels_scanner/general_providers/camera_provider.dart';

import '../../../auth_component/data/auth_state.dart';
import '../../../auth_component/providers/auth_providers.dart';
import '../../Signup/components/background.dart';

class LoginScreenWidget extends ConsumerStatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginScreenWidget> {
  late TextEditingController _emailIdController;
  late TextEditingController _passwordController;

  Future<void> _login() async {
    final String email = _emailIdController.text;
    final String password = _passwordController.text;

    //await ref.read(authStateProvider.notifier).login(email, password);
    //final AuthStatus status = ref.read(authStateProvider).authStatus;

    /*
   Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AppHome()));
*/

    ref.watch(
        mobileCamerasPrefsDataProvider); //search cameras before getting to camera page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AppTabsHome()));

    /*
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const AppHome()));
    }
    */
  }

  @override
  void initState() {
    super.initState();
    _emailIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailIdController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthRequestStatus loginStatus =
        ref.watch(authStateProvider).loginStatus;
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/login.svg',
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {},
              icon: Icons.email,
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
                onPressed: _login,
                child: (loginStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Log In")),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
