import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/app_screen.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';

class QrCodesScreen extends AppScreen<QrCodesSegment> {
  QrCodesScreen(QrCodesSegment segment)
      : super(segment, 'QrCode ${segment.id}');

  @override
  List<Widget> buildWidgets(navigator) => [
        ElevatedButton(
          onPressed: navigator.toQrCode,
          child: const Text('Go to next qr code'),
        ),
      ];
}
