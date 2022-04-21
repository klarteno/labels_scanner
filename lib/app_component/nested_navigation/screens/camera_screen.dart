import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:riverpod_navigator/riverpod_navigator.dart';

import '../app_navigator.dart';

/// common app screen
abstract class CameraScreen<S extends TypedSegment>
    extends RScreen<AppNavigator, S> {
  CameraScreen(S segment, screenTitle) : super(segment);

  final String screenTitle = "nnfnfnf";

  late CustomPaint? customPaint;
  final CustomPaint? customPaint22 = null;

  set setCustomPaint(CustomPaint value) {
    customPaint = value;
  }

  void setCustomPaint2(CustomPaint customPaint) {
    customPaint = customPaint;
  }

  @override
  Widget buildScreen(context, ref, navigator, appBarLeading) => Scaffold(
        appBar: AppBar(
          title: const Text("screenTitle"),
          leading: appBarLeading,
        ),
        body: Center(
          child: Column(
            children: [buildWidgets(navigator)],
          ),
        ),
      );

  Widget buildWidgets(AppNavigator navigator);
}
