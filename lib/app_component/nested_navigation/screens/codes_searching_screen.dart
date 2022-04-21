import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/app_screen.dart';

class CodesSearchingScreen extends AppScreen<CodesSearchingSegment> {
  const CodesSearchingScreen(CodesSearchingSegment barCodesScanner)
      : super(barCodesScanner, 'CodesSearching');

  @override
  List<Widget> buildWidgets(navigator) => [
        ElevatedButton(
          onPressed: () => null,
          child: const Text('Go to next Bar Code'),
        ),
      ];
}
