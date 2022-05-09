import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/position_wrapper.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/scanner_form_details.dart';

import 'bar_code_wrapper.dart';

part 'barcode_scanned_details.g.dart';

@HiveType(typeId: 17)
class BarcodeScannedDetails {
  BarcodeScannedDetails(this.scannerFormDetails, {required this.barCodeData});

  factory BarcodeScannedDetails.empty() {
    var barCodeData2 = BarCodeData(
        barcodeValueType: '',
        barcodeValueFormat: '',
        barcodeValueDisplayValue: '',
        barcodeValueRawValue: '');

    return BarcodeScannedDetails(null, barCodeData: barCodeData2);
  }

  @HiveField(18)
  final BarCodeData barCodeData;

  @HiveField(19)
  late ScannerFormDetails? scannerFormDetails;

  @HiveField(20)
  late PositionData? positionData;

  @HiveField(21)
  var key = UniqueKey().toString();
}
