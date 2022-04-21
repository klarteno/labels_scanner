import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/my_products/tags/tags_routers/tags_routers.dart';
import 'package:labels_scanner/myshopify/myshopify_repository/myshopify_repository.dart';

final myshopifyRepositoryProvider = Provider<MyShopifyRepository>((ref) {
  return MyShopifyRepository();
});

class TagsApp extends StatelessWidget {
  const TagsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              actionsIconTheme: const IconThemeData(color: Colors.amber),
              centerTitle: false,
              elevation: 20.7,
              titleTextStyle: TextStyle(
                  color: Colors.cyan,
                  fontSize: 17,
                  height: 1,
                  fontFamily: "alex",
                  fontWeight: FontWeight.w700))),
      themeMode: ThemeMode.system,
      onGenerateRoute: TagsRouter.route,
      initialRoute: MyProductsPages.tags,
    );
  }
}
