import 'package:hive_flutter/hive_flutter.dart';

part 'bar_code_wrapper.g.dart';

@HiveType(typeId: 12)
class BarCodeData {
  BarCodeData({
    required this.barcodeValueType,
    required this.barcodeValueFormat,
    required this.barcodeValueDisplayValue,
    required this.barcodeValueRawValue,
  });

  @HiveField(13)
  String barcodeValueType;

  @HiveField(14)
  String barcodeValueFormat;

  @HiveField(15)
  String barcodeValueDisplayValue;

  @HiveField(16)
  String barcodeValueRawValue;
}
