import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/bar_code_wrapper.dart';

import 'app_component/screens/Welcome/welcome_screen.dart';
import 'camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'camera_component/model_barcodes/db_models/db_interface.dart';
import 'camera_component/model_barcodes/db_models/scanner_form_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DbInterface.initHiveDb();

// Registering the adapter
  Hive.registerAdapter(ScannerFormDetailsAdapter());
  Hive.registerAdapter(BarCodeDataAdapter());
  Hive.registerAdapter(BarcodeScannedDetailsAdapter());
  //Hive.deleteFromDisk();
  //Hive.ignoreTypeId<BarcodeScannedDetails>(0);
  //Future.delayed(const Duration(seconds: 1));

  var box1 = await DbInterface.openDbBarcodesDisplay().then((value) {
    return value;
  }).whenComplete(() => null);

  var box2 = await DbInterface.openDbBarcodesDismissed().then((value) {
    return value;
  }).whenComplete(() => null);

  var box3 = await DbInterface.openDbQrcodesDisplay()
      .then((value) => value)
      .whenComplete(() => null);

  var box4 = await DbInterface.openDbQrcodesDismissed()
      .then((value) => value)
      .whenComplete(() => null);

  runApp(const ProviderScope(child: WelcomeScreen()));
}
