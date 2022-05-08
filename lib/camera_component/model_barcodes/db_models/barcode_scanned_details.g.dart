// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scanned_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeScannedDetailsAdapter extends TypeAdapter<BarcodeScannedDetails> {
  @override
  final int typeId = 17;

  @override
  BarcodeScannedDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeScannedDetails(
      fields[19] as ScannerFormDetails?,
      barCodeData: fields[18] as BarCodeData,
    )..key = fields[20] as String;
  }

  @override
  void write(BinaryWriter writer, BarcodeScannedDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(18)
      ..write(obj.barCodeData)
      ..writeByte(19)
      ..write(obj.scannerFormDetails)
      ..writeByte(20)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeScannedDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
