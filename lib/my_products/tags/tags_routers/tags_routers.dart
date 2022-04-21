import 'package:flutter/material.dart';
import 'package:labels_scanner/my_products/details/view/details_page.dart';
import 'package:labels_scanner/my_products/product/view/product_page.dart';
import 'package:labels_scanner/my_products/tags/view/tags_page.dart';

/// Dengun MyshopifyPages for the Dengun route
class MyProductsPages {
  /// The first page when the app loads
  static const String tags = '/';

  /// Dengun notificaiton details page
  static const String product = '/product';

  /// Dengun notificaiton details page
  static const String details = '/details';
}

///The main app routes logic using router generator
class TagsRouter {
  ///list of all the app routes
  static Route route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case MyProductsPages.tags:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const TagsPage();
          },
        );
      case MyProductsPages.product:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ProductPage(tag: args!.toString());
          },
        );
      case MyProductsPages.details:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return DetailsPage(productId: args!);
          },
        );
      default:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const Text('Error');
          },
        );
    }
  }
}
