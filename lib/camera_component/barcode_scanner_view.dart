import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:labels_scanner/camera_component/forms_imputs/complete_form.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'package:labels_scanner/camera_component/providers/providers_of_scanned_codes.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'camera_view.dart';
import 'model_barcodes/db_models/bar_code_wrapper.dart';
import 'painters/barcode_detector_painter.dart';

class BarCodeScannerView extends ConsumerStatefulWidget {
  const BarCodeScannerView({Key? key}) : super(key: key);

  @override
  ConsumerState<BarCodeScannerView> createState() {
    return _BarCodeScannerViewState();
  }
}

class _BarCodeScannerViewState extends ConsumerState<BarCodeScannerView> {
  late BarcodeScanner barcodeScanner;
  bool isBusy = false;
  CustomPaint? customPaint;

  late List<CameraDescription>? mobileCameras;

  final double _initFabHeight = 10.0;
  double _fabHeight = 0;
  late double _panelHeightOpen = 50;
  final double _panelHeightClosed = 20.0;

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
    _panelHeightOpen = MediaQuery.of(context).size.height * .60;

    //Hive.registerAdapter(BarcodeScannedDetailsAdapter());

    return ProviderScope(
        child: MaterialApp(
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
    ));
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

    if (barcodes.isNotEmpty) {
      print('Found ${barcodes.length} barcodes');

/*
      BarcodeType barcodeType = barcode.type;
      print('BarcodeType  has string ${barcodeType.name.toString()} ');
      String barcode_type = barcodeType.name.toString();

      BarcodeValue barcodeValue = barcode.value;
      print('BarcodeValue  has string ${barcodeValue.toString()} ');

      BarcodeType barcodeValueType = barcodeValue.type;
      print(
          'barcodeValueType  has string ${barcodeValueType.name.toString()} ');
      String barcode_value_type = barcodeValueType.name.toString();

      BarcodeFormat barcodeFormat = barcodeValue.format;
      print('BarcodeFormat  has string ${barcodeFormat.name.toString()} ');
      String barcode_format = barcodeFormat.name.toString();

      String? barcodeRawValue = barcodeValue.rawValue;
      print('BarcodeRawValue  has string ${barcodeRawValue.toString()} ');
      String barcode_raw_value = barcodeRawValue.toString();

      String? barcodeDisplayValue = barcodeValue.displayValue;
      print(
          'BarcodeDisplayValue  has string ${barcodeDisplayValue.toString()} ');
      String barcode_display_value = barcodeDisplayValue.toString();

      Rect? barcodeBoundingBox = barcodeValue.boundingBox;
      print('BarcodeBoundingBox  has string ${barcodeBoundingBox.toString()} ');

      var barcodeRawBytes = barcodeValue.rawBytes;
      print('BarcodeRawBytes  has string ${barcodeRawBytes.toString()} ');
*/
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      if (barcodes.isNotEmpty) {
        Barcode barcode = barcodes.first;

        BarCodeData barCodeData = BarCodeData(
            barcodeValueType: barcode.value.type.toString(),
            barcodeValueFormat:
                barcode.value.format.toString().split(".").last.toLowerCase(),
            barcodeValueDisplayValue: barcode.value.displayValue.toString(),
            barcodeValueRawValue: barcode.value.rawValue.toString());

        var barcodeScannedDetails =
            BarcodeScannedDetails(null, barCodeData: barCodeData);

        //ref.watch(barcodesProvider.notifier).resetState();

        ref
            .watch(barcodesProvider.notifier)
            .addBarcodeData(barcodeScannedDetails);
      }
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
    var _isQrCode = false;
    var _barcode = ref.watch(barcodesProvider);

    String scannedFormat =
        _barcode.barCodeData.barcodeValueFormat.toString().toLowerCase();
    if (scannedFormat == 'qrcode') {
      _isQrCode = true;
    } else {
      _isQrCode = false;
    }
    return MediaQuery.removePadding(
        context: context,
        removeTop: false,
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
                  decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Scanned Format: ' + scannedFormat,
                          key: const ValueKey('label_code'),
                          style: const TextStyle(inherit: true),
                          textAlign: TextAlign.left),
                      const SizedBox(
                        width: 5.0,
                      ),
                      _isQrCode
                          ? const Icon(Icons.qr_code_2_sharp,
                              size: 25, color: Colors.black)
                          : const Icon(FontAwesomeIcons.barcode,
                              size: 25, color: Colors.black),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                    child: Divider(
                        height: 10, thickness: 1, color: Colors.black54),
                  ),
                  Text(
                      'Scanned Code Value: ' +
                          _barcode.barCodeData.barcodeValueDisplayValue
                              .toString(),
                      key: const ValueKey('code_value'),
                      style: const TextStyle(inherit: true),
                      textAlign: TextAlign.left),
                  const SizedBox(
                    height: 15.0,
                    child: Divider(
                        height: 10, thickness: 1, color: Colors.black54),
                  ),
                ],
              ),
            ),

            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("Get Barcode", Icons.favorite, Colors.blue),
                _button("set ", Icons.restaurant, Colors.red),
                _button("Events", Icons.event, Colors.amber),
                _button("More", Icons.more_horiz, Colors.green),
              ],
            ),*/
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
