import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materials_products_repository/my_materials_repository.dart';
import 'package:state_notifier/state_notifier.dart';

part 'tags_state.dart';
/*
final configProvider = FutureProvider<TagsState>((ref) async {
  final content = json.decode(
    await rootBundle.loadString('assets/configurations.json'),
  ) as Map<String, Object?>;

  return TagsState.fromJson(content);
});

final userFamily =
    FutureProvider.family<List<Product>, String>((ref, searchString) async {
  final userRepository = ref.watch(myshopifyRepositoryProvider);
  Future<List<Product>> searchedTags =
      userRepository.getProductsWithTag(searchString);
  // Future<List<Product>> searched_tags

  return searchedTags;
});

final repositoryProvider =
    Provider.family<String, FutureProvider<Configurations>>(
        (ref, configurationsProvider) {
  final MyMaterialsProductsRepository _myShopifyRepository =
      MyMaterialsProductsRepository();

  // Read a provider without knowing what that provider is.
  final configurations = _myShopifyRepository.getTags();
  return Repository(host: configurations.host);
});

final my_tags = FutureProvider<List<Tag>>((ref) async {
  var ress =ref.watch(myshopifyRepositoryProvider).getTags();
  ress.
  return ref.watch(myshopifyRepositoryProvider).getTags();
});

final userFamily2 =
    FutureProvider.family<List<Tag>, int>((ref, searchString) async {
  final userRepository = ref.watch(my_tags);
  var _result = userRepository.asData;

  var vvvvv = _result?.value;
  var ress = Future.value(_result?.value);
  return ress;
});

final userFamily3 =
    FutureProvider.family<List<Tag>, int>((ref, searchString) async {
  final userRepository = ref.watch(myshopifyRepositoryProvider).getTags();
  var ffff = userFamily2.call(3);
  return userRepository;
});

final myshopifyRepositoryProvider4 =
    Provider<MyMaterialsProductsRepository>((ref) {
  return MyMaterialsProductsRepository();
});
*/

class TagsNotifier extends StateNotifier<TagsState> {
  TagsNotifier(this._myShopifyRepository) : super(const TagsState());

  final MyMaterialsProductsRepository _myShopifyRepository;

  Future<void> tags() async {
    try {
      state = state.copyWith(status: TagsStatus.loading);
      final response = await _myShopifyRepository.getTags();
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

  Future<void> onSearchChanged(String value) async {
    state = state.copyWith(status: TagsStatus.loading);
    if (value.isEmpty) {
      final response = await _myShopifyRepository.getTags();
      state = state.copyWith(status: TagsStatus.success, tags: response);
    } else {
      final searchResult = state.tags
          .where((element) => element.name!
              .trim()
              .toLowerCase()
              .contains(value.trim().toLowerCase()))
          .toList();
      if (searchResult.isEmpty) {
        final response = await _myShopifyRepository.getTags();
        state = state.copyWith(status: TagsStatus.success, tags: response);
      } else {
        state = state.copyWith(status: TagsStatus.success, tags: searchResult);
      }
    }
  }
}
