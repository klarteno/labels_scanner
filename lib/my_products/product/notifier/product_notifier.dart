import 'package:equatable/equatable.dart';
import 'package:materials_products_repository/my_materials_repository.dart';
import 'package:state_notifier/state_notifier.dart';

part 'product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier(this._myShopifyRepository) : super(const ProductState());

  final MyMaterialsProductsRepository _myShopifyRepository;

  Future<void> getProductWithTag({required String tag}) async {
    try {
      state = state.copyWith(status: ProductStatus.loading);
      final response = await _myShopifyRepository.getProductsWithTag(tag);
      state = state.copyWith(status: ProductStatus.success, products: response);
    } on ProductRequestError {
      state = state.copyWith(
          status: ProductStatus.failure,
          errorMessage: 'Something went wrong, Try again');
    } on ProductError {
      state = state.copyWith(
          status: ProductStatus.failure,
          errorMessage: 'No internet connection');
    }
  }
}
