import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/app_home.dart';

import 'package:labels_scanner/authentication_component/providers/account.dart';
import 'package:labels_scanner/authentication_component/providers/entry.dart';
import 'package:labels_scanner/authentication_component/providers/watchlist.dart';
import 'package:labels_scanner/authentication_component/screens/Welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

List<CameraDescription> mobileCameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  mobileCameras = await availableCameras();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => EntryProvider()),
      ChangeNotifierProvider(create: (context) => WatchListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Labels Scanner App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: context.read<AccountProvider>().isValid(),
            builder: (context, snapshot) =>
                context.watch<AccountProvider>().session == null
                    ? const WelcomeScreen()
                    : AppHome(
                        cameras: mobileCameras,
                      )));
  }
}
