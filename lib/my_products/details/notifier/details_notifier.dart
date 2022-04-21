import 'package:equatable/equatable.dart';
import 'package:labels_scanner/myshopify/myshopify_repository/model/product.dart';
import 'package:labels_scanner/myshopify/myshopify_repository/myshopify_repository.dart';
import 'package:state_notifier/state_notifier.dart';

part 'details_state.dart';

class DetailsNotifier extends StateNotifier<DetailsState> {
  DetailsNotifier(this._myShopifyRepository) : super(const DetailsState());

  final MyShopifyRepository _myShopifyRepository;

  Future<void> getProduct({required int id}) async {
    try {
      state = state.copyWith(status: DetailsStatus.loading);
      final response = await _myShopifyRepository.getProductsWithId(id);
      state = state.copyWith(status: DetailsStatus.success, product: response);
    } on Exception {
      state = state.copyWith(status: DetailsStatus.failure);
    }
  }
}
