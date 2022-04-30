import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/my_products/tags/notifier/tags_notifier.dart';
import 'package:labels_scanner/my_products/tags/tags_routers/tags_routers.dart';

import '../../../myshopify/providers/shopify_repository.dart';

final tagsProvider = StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  return TagsNotifier(ref.read(myshopifyRepositoryProvider));
});

class TagsPage extends ConsumerStatefulWidget {
  const TagsPage({Key? key}) : super(key: key);

  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends ConsumerState<TagsPage> {
  final _pageListKey1 = const PageStorageKey("list_tags");
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    //ref.read(tagsProvider.notifier).tags();
    super.initState();

    Future.delayed(Duration.zero, () => ref.read(tagsProvider.notifier).tags());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tagNotifier = ref.watch(tagsProvider);
    Future.delayed(Duration.zero, () => 5);
/*
    Future.delayed(Duration.zero, () => ref.read(tagsProvider))
        .then((value) => tagNotifier = value);
  */
    final color = Theme.of(context).primaryColorLight;

    return PageStorage(
      bucket: _pageStorageBucket,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: ref.read(tagsProvider.notifier).onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Showing ${tagNotifier.tags.length} tags',
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (tagNotifier.status == TagsStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (tagNotifier.status == TagsStatus.success) {
                        return ListView.separated(
                          key: _pageListKey1,
                          addAutomaticKeepAlives: true,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              color: color.withOpacity(0.99),
                              shadowColor: color,
                              child: ListTile(
                                onTap: () => Navigator.of(context).pushNamed(
                                    MyProductsPages.product,
                                    arguments: tagNotifier.tags[index].name!),
                                title: Text(
                                  tagNotifier.tags[index].name!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 0),
                          itemCount: tagNotifier.tags.length,
                        );
                      } else if (tagNotifier.status == TagsStatus.failure) {
                        return Center(
                          child: Text(tagNotifier.errorMessage),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
