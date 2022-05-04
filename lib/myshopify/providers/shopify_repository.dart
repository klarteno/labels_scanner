import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materials_products_repository/my_materials_repository.dart';

final myshopifyRepositoryProvider =
    Provider<MyMaterialsProductsRepository>((ref) {
  var ffff = ref.watch(myTags);

  return MyMaterialsProductsRepository();
});

final myTags = FutureProvider((ref) async {
  return await MyMaterialsProductsRepository().getTags();
});
