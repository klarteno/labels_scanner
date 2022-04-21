import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';
import 'package:riverpod_navigator/riverpod_navigator.dart';

import 'app_navigator.dart';

/// TabBarView screen
class AppComponentsTab
    extends RScreenHook<AppNavigator, AppComponentsTabSegment> {
  const AppComponentsTab(AppComponentsTabSegment appComponentsTabSegment)
      : super(appComponentsTabSegment);

  @override
  Widget buildScreen(context, ref, navigator, appBarLeading) {
    /// Remembering RestorePath throughout the widget's lifecycle
    /// Note: *We use **flutter_hooks package** to keep RestorePath instance.
    /// The use of flutter_hooks is not mandatory, it can be implemented using the StatefulWidget*.
    final restoreQrCodes = useMemoized(() => RestorePath());
    final restoreBarCodes = useMemoized(() => RestorePath());
    final restoreCodesSearching = useMemoized(() => RestorePath());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: appBarLeading,
          title: const Text("Labels Scanner"),
          toolbarHeight: 28,
          shadowColor: Colors.deepPurpleAccent,
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            null,
            0,
          ),
          bottom: TabBar(
            labelColor: Colors.lightGreenAccent,
            overlayColor: MaterialStateProperty.all<Color?>(
              Colors.indigo,
            ),
            indicatorColor: Colors.white,
            tabs: const <Widget>[
              Tab(icon: Icon(CupertinoIcons.qrcode_viewfinder), height: 25),
              Tab(icon: Icon(CupertinoIcons.barcode_viewfinder), height: 25),
              Tab(icon: Icon(Icons.image_search_outlined), height: 25),
              //Tab(icon: Icon(CupertinoIcons.photo_on_rectangle)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => null,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => null,
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => null,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            ProviderScope(
              // The RestorePath class preserves the last state of the navigator.
              // Used during the next navigator initialization.
              overrides: riverpodNavigatorOverrides(
                [const BarCodesSegment(id: 2)],
                AppNavigator.forBarCodes,
                restorePath: restoreBarCodes,
              ),
              child: const BarCodesTab(),
            ),
            ProviderScope(
              overrides: riverpodNavigatorOverrides(
                [const QrCodesSegment(id: 2)],
                AppNavigator.forQrCodes,
                restorePath: restoreQrCodes,
              ),
              child: const QrCodesTab(),
            ),
            ProviderScope(
              overrides: riverpodNavigatorOverrides(
                [const CodesSearchingSegment()],
                AppNavigator.forCodesSearching,
                restorePath: restoreCodesSearching,
              ),
              child: const CodesSearchingTab(),
            ),
          ],
        ),
      ),
    );
  }
}

// https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9
class BarCodesTab extends ConsumerWidget {
  const BarCodesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Router(
      routerDelegate:
          (ref.read(navigatorProvider) as AppNavigator).routerDelegate);
}

class QrCodesTab extends ConsumerWidget {
  const QrCodesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Router(
      routerDelegate:
          (ref.read(navigatorProvider) as AppNavigator).routerDelegate);
}

class CodesSearchingTab extends ConsumerWidget {
  const CodesSearchingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Router(
      routerDelegate:
          (ref.read(navigatorProvider) as AppNavigator).routerDelegate);
}
