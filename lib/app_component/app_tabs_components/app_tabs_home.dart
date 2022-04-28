import 'dart:async';

import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/app_tabs_components/whatsapp_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppTabsHome());
}

class AppTabsHome extends StatelessWidget {
  const AppTabsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp",
      theme: ThemeData(
        primaryColor: const Color(0xff075E54),
        accentColor: const Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: WhatsAppHome(),
    );
  }
}
