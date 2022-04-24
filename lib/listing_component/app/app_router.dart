import 'package:labels_scanner/listing_component/details/view/details_page.dart';
import 'package:labels_scanner/listing_component/product/product.dart';
import 'package:labels_scanner/listing_component/tags/tags.dart';
import 'package:flutter/material.dart';

/// Dengun MyshopifyPages for the Dengun route
class MyshopifyPagesPath {
  /// The first page when the app loads
  static const String tags = '/';

  /// Dengun notificaiton details page
  static const String product = '/product';

  /// Dengun notificaiton details page
  static const String details = '/details';
}

///The main app routes logic using router generator
class AppRouter {
  ///list of all the app routes
  static Route route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case MyshopifyPagesPath.tags:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const TagsPage();
          },
        );
      case MyshopifyPagesPath.product:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ProductPage(tag: args!.toString());
          },
        );
      case MyshopifyPagesPath.details:
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
