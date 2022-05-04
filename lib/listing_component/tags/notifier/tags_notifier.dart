import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materials_products_repository/my_materials_repository.dart';

part 'tags_state.dart';

class TagsNotifier extends StateNotifier<TagsState> {
  TagsNotifier(this._materialsProductsRepository) : super(const TagsState());

  final MyMaterialsProductsRepository _materialsProductsRepository;

  Future<void> tags() async {
    try {
      state = state.copyWith(status: TagsStatus.loading);
      final response = await _materialsProductsRepository.getTags();
      state = state.copyWith(status: TagsStatus.success, tags: response);
    } on TagRequestError {
      state = state.copyWith(
          status: TagsStatus.failure,
          errorMessage: 'Something went wrong, Try again');
    } on TagError {
      state = state.copyWith(
          status: TagsStatus.failure, errorMessage: 'No internet connection');
    }
  }

  void onSearchChanged(String value) async {
    state = state.copyWith(status: TagsStatus.loading);
    if (value.isEmpty) {
      final response = await _materialsProductsRepository.getTags();
      state = state.copyWith(status: TagsStatus.success, tags: response);
    } else {
      final searchResult = state.tags
          .where((element) => element.name!
              .trim()
              .toLowerCase()
              .contains(value.trim().toLowerCase()))
          .toList();
      if (searchResult.isEmpty) {
        final response = await _materialsProductsRepository.getTags();
        state = state.copyWith(status: TagsStatus.success, tags: response);
      } else {
        state = state.copyWith(status: TagsStatus.success, tags: searchResult);
      }
    }
  }
}
