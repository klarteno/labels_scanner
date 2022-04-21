import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/myshopify/myshopify_repository/myshopify_repository.dart';

final myshopifyRepositoryProvider = Provider<MyShopifyRepository>((ref) {
  return MyShopifyRepository();
});
