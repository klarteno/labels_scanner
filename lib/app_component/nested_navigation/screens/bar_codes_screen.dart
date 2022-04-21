import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/app_screen.dart';

class BarCodesScreen extends AppScreen<BarCodesSegment> {
  BarCodesScreen(BarCodesSegment barCodes)
      : super(barCodes, 'Tag ${barCodes.id}');

  @override
  List<Widget> buildWidgets(navigator) => [
        ElevatedButton(
          onPressed: navigator.toBarCodes,
          child: const Text('Go to next Bar Code'),
        ),
      ];
}
