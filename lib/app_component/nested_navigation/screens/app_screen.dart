import 'package:flutter/material.dart';
import 'package:riverpod_navigator/riverpod_navigator.dart';

import '../app_navigator.dart';

/// common app screen
abstract class AppScreen<S extends TypedSegment>
    extends RScreen<AppNavigator, S> {
  const AppScreen(S segment, this.screenTitle) : super(segment);

  final String screenTitle;

  @override
  Widget buildScreen(context, ref, navigator, appBarLeading) => Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          leading: appBarLeading,
        ),
        body: Center(
          child: Column(
            children: [
              for (final w in buildWidgets(navigator)) ...[
                const SizedBox(height: 20),
                w
              ],
              const SizedBox(height: 20),
              Text(
                  'Dump actual typed-path: "${navigator.debugSegmentSubpath(segment)}"'),
            ],
          ),
        ),
      );

  List<Widget> buildWidgets(AppNavigator navigator);
}
