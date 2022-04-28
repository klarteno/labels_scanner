import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labels_scanner/app_component/auth_component/data/auth_state.dart';
import 'package:labels_scanner/app_component/auth_component/providers/auth_providers.dart';
import 'package:labels_scanner/tasks/tasks_list_page.dart';

import '../screens/Welcome/components/background.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //
  // ########## Lifecycle
  //

  @override
  void initState() {
    super.initState();

    // Doesn't work. Might be related to SharedPreferences not being ready at
    // the time this is fired given the quick start scenario.
    _getActiveSession();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  //
  // ########## Events
  //

  Future<void> _getActiveSession() async {
    await ref.read(authStateProvider.notifier).getActiveSession();

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  Future<void> _signUp() async {
    final String email = _emailController.text;
    final String password = _emailController.text;
    const String name = "my random name";

    await ref
        .read(authStateProvider.notifier)
        .signUp(name: name, email: email, password: password);

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _emailController.text;

    await ref.read(authStateProvider.notifier).login(email, password);

    final AuthStatus status = ref.read(authStateProvider).authStatus;
    if (status == AuthStatus.authenticated) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const TaskListPage()));
    }
  }

  //
  // ########## UI
  //

  Widget _buildBody() {
    final AuthRequestStatus loginStatus =
        ref.watch(authStateProvider).loginStatus;

    final AuthRequestStatus signUpStatus =
        ref.watch(authStateProvider).signUpStatus;

    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the scanner',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
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
                ),
                onPressed: _login,
                child: (loginStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Log In")),
            ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
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
                ),
                onPressed: _signUp,
                child: (signUpStatus == AuthRequestStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("scanners Demo"),
      ),
      body: _buildBody(),
    );
  }
}
