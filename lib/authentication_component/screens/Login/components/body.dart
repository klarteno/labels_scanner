import 'package:labels_scanner/authentication_component/components/already_have_an_account_check.dart';
import 'package:labels_scanner/authentication_component/components/rounded_button.dart';
import 'package:labels_scanner/authentication_component/components/rounded_input_field.dart';
import 'package:labels_scanner/authentication_component/components/rounded_password_field.dart';
import 'package:labels_scanner/authentication_component/screens/Login/components/background.dart';
import 'package:labels_scanner/authentication_component/screens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../app_home.dart';
import '../../../../main.dart';
import '../../../providers/account.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> press(BuildContext context) async {
    final accountService = context.read<AccountProvider>();
    String snackBarText = 'Logged in successfully!';

    bool successfullyLoggedIn = true;
    int snackBarTime = 4500;

    try {
      await accountService.signIn(
        email: _emailIdController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      snackBarText = e.toString();
      snackBarTime = 4500;
      successfullyLoggedIn = false;
    }
    SnackBar newUserSnackBar = SnackBar(
      content: Text(snackBarText),
      duration: Duration(milliseconds: snackBarTime),
    );

    ScaffoldMessenger.of(context).showSnackBar(newUserSnackBar);
    if (successfullyLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AppHome(
              cameras: mobileCameras,
            );
          },
        ),
      );
    }
  }

  late TextEditingController _emailIdController;
  late TextEditingController _passwordController;

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
            RoundedButton(
              text: 'Login',
              press: press,
            ),
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
