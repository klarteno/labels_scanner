import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:labels_scanner/camera_component/forms_imputs/complete_form.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'camera_view.dart';
import 'painters/barcode_detector_painter.dart';

class BarCodeScannerView extends StatefulWidget {
  const BarCodeScannerView({Key? key}) : super(key: key);

  @override
  _BarCodeScannerViewState createState() => _BarCodeScannerViewState();
}

class _BarCodeScannerViewState extends State<BarCodeScannerView> {
  late BarcodeScanner barcodeScanner;
  bool isBusy = false;
  CustomPaint? customPaint;

  late List<CameraDescription>? mobileCameras;

  final double _initFabHeight = 10.0;
  double _fabHeight = 0;
  late double _panelHeightOpen = 0;
  final double _panelHeightClosed = 17.0;

  @override
  void initState() {
    barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .65;

    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Material(
        type: MaterialType.canvas,
        elevation: 25,
        child: SlidingUpPanel(
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          color: Colors.green,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: _body(),
          panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          onPanelSlide: (double pos) => setState(() {
            _fabHeight =
                pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
            //print("_fabHeight.toString()  " + _fabHeight.toString());
          }),
        ),
      ),
    );
  }

  Widget _body() {
    return CameraView(
        title: 'Barcode Scanner',
        customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        });
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);
    //print('Found ${barcodes.length} barcodes');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Get Barcode", Icons.favorite, Colors.blue),
                _button("Food", Icons.restaurant, Colors.red),
                _button("Events", Icons.event, Colors.amber),
                _button("More", Icons.more_horiz, Colors.green),
              ],
            ),
            const CompleteForm(),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[],
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: 8.0,
                )
              ]),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }
}
