import 'package:labels_scanner/app_component/screens/Login/login_screen.dart';
import 'package:labels_scanner/app_component/screens/Signup/signup_screen.dart';
import 'package:labels_scanner/app_component/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> pressLogin() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
    }

    Future<void> pressSignup() async {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      );
    }

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Scanner Labels',
              style: TextStyle(
                  foreground: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 4.0
                    ..style = PaintingStyle.fill,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 1,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Trazan Pro"),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontFamily: "alex")),
                //padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                //  vertical: 20, horizontal: 140)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 120)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              onPressed: pressLogin,
              child: const Text("Log In"),
            ),
            SizedBox(height: size.height * 0.02),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontFamily: "alex")),
                //padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                //  vertical: 20, horizontal: 140)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 120)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
              onPressed: pressSignup,
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
