import 'package:hive_flutter/hive_flutter.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'package:path_provider/path_provider.dart';

class DbInterface {
  static const String hive_box_barcodes = 'scanned_barcodes_box';
  static const String hive_box_barcodes_dismissed =
      'scanned_barcodes_box_dismissed';

  static const String hive_box_qrcodes = 'sc_qrcodes_box';
  static const String hive_box_qrcodes_dismissed = 'sc_qrcodes_box_dismissed';

  static Future<Box> _openHiveBoxExample(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    return await Hive.openBox(boxName);
  }

  static Future<void> initHiveDb() async {
    return await Hive.initFlutter(
        (await getApplicationDocumentsDirectory()).path);
  }

  ///
  static Future<Box<BarcodeScannedDetails>> _openDb(String nameBox) async {
    Box<BarcodeScannedDetails> box =
        await Hive.openBox<BarcodeScannedDetails>(nameBox);
    return box;
  }

  static Box<BarcodeScannedDetails> _getDb(String nameBox) {
    return Hive.box<BarcodeScannedDetails>(nameBox);
  }

  ///
  static Future<Box<BarcodeScannedDetails>> openDbBarcodesDisplay() async {
    return _openDb(hive_box_barcodes);
  }

  static Box<BarcodeScannedDetails> getDbBarcodesDisplay() {
    return _getDb(hive_box_barcodes);
  }

  ///
  static Future<Box<BarcodeScannedDetails>> openDbBarcodesDismissed() async {
    return _openDb(hive_box_barcodes_dismissed);
  }

  static Box<BarcodeScannedDetails> getDbBarcodesDismissed() {
    return _getDb(hive_box_barcodes_dismissed);
  }

  ///
  static Future<Box<BarcodeScannedDetails>> openDbQrcodesDisplay() async {
    return _openDb(hive_box_qrcodes);
  }

  static Box<BarcodeScannedDetails> getDbQrcodesDisplay() {
    return _getDb(hive_box_qrcodes);
  }

  ///
  static Future<Box<BarcodeScannedDetails>> openDbQrcodesDismissed() async {
    return _openDb(hive_box_qrcodes_dismissed);
  }

  static Box<BarcodeScannedDetails> getDbQrcodesDismissed() {
    return _getDb(hive_box_qrcodes_dismissed);
  }

  static Future<void> deleteDbUsersDismissed() async {
    Hive.box<BarcodeScannedDetails>(hive_box_barcodes_dismissed);
    await Hive.box(hive_box_barcodes_dismissed).deleteFromDisk();
  }

  static Future<void> deleteDbUsersDisplay() async {
    Hive.box<BarcodeScannedDetails>(hive_box_barcodes);
    await Hive.box(hive_box_barcodes).deleteFromDisk();
  }
}
