import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materials_products_repository/my_materials_repository.dart';

part 'details_state.dart';

class DetailsNotifier extends StateNotifier<DetailsState> {
  DetailsNotifier(this._materialsProductsRepository)
      : super(const DetailsState());

  final MyMaterialsProductsRepository _materialsProductsRepository;

  Future<void> getProduct({required int id}) async {
    try {
      state = state.copyWith(status: DetailsStatus.loading);
      final response = await _materialsProductsRepository.getProductsWithId(id);
      state = state.copyWith(status: DetailsStatus.success, product: response);
    } on Exception {
      state = state.copyWith(status: DetailsStatus.failure);
    }
  }
}
