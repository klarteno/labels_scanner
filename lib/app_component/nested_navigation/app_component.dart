import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_navigator/riverpod_navigator.dart';

import 'app_navigator.dart';
import 'models/TypedSegment.dart';

/*
examples
void main() => runApp(
      ProviderScope(
        overrides: riverpodNavigatorOverrides(
            [const HomeComponentsTabsSegment()], AppNavigator.new),
        child: const AppComponent(),
      ),
    );

Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ProviderScope(
              overrides: riverpodNavigatorOverrides(
                  [const HomeComponentsTabsSegment()], AppNavigator.new),
              child: const AppComponent(),
            )));
*/
class AppComponent extends ConsumerWidget {
  const AppComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.read(navigatorProvider) as AppNavigator;

    return MaterialApp.router(
      title: 'My Scanner Navigator Example',
      routerDelegate: navigator.routerDelegate,
      routeInformationParser: navigator.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
