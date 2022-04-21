import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/app_screen.dart';

const count = 3;

class HomeComponentsTabsScreen extends AppScreen<HomeComponentsTabsSegment> {
  const HomeComponentsTabsScreen(HomeComponentsTabsSegment segment)
      : super(segment, "screenTitle");

  @override
  List<Widget> buildWidgets(navigator) => [
        const Text('Welcome to Scanner App', style: TextStyle(fontSize: 32)),
        ElevatedButton(
          onPressed: () => navigator.navigate([
            const HomeComponentsTabsSegment(),
            const AppComponentsTabSegment()
          ]),
          child: const Text('Enter App'),
        ),
      ];
}
