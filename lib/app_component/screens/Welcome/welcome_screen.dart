import 'package:labels_scanner/app_component/screens/Welcome/components/welcome_screen_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xxxxxxxxxx',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.indigoAccent,
              // This will be applied to the "back" icon
              iconTheme:
                  IconThemeData(color: Colors.lightGreen, opacity: 1, size: 23),
              // This will be applied to the action icon buttons that locates on the right side
              actionsIconTheme: IconThemeData(color: Colors.amber),
              centerTitle: false,
              elevation: 20.7,
              titleTextStyle: TextStyle(
                  color: Colors.cyan,
                  fontSize: 17,
                  height: 1,
                  fontFamily: "alex",
                  fontWeight: FontWeight.w700))),
      //onGenerateRoute: TagsRouter.route,
      //initialRoute: MyProductsPages.tags,
      home: const WelcomeScreenWidget(),
    );
  }
}
