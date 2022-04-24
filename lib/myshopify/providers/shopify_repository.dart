import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materials_products_repository/my_materials_repository.dart';

final myshopifyRepositoryProvider =
    Provider<MyMaterialsProductsRepository>((ref) {
  return MyMaterialsProductsRepository();
});
