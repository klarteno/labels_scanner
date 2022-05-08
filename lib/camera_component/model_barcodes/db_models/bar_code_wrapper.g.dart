// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_code_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarCodeDataAdapter extends TypeAdapter<BarCodeData> {
  @override
  final int typeId = 12;

  @override
  BarCodeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarCodeData(
      barcodeValueType: fields[13] as String,
      barcodeValueFormat: fields[14] as String,
      barcodeValueDisplayValue: fields[15] as String,
      barcodeValueRawValue: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarCodeData obj) {
    writer
      ..writeByte(4)
      ..writeByte(13)
      ..write(obj.barcodeValueType)
      ..writeByte(14)
      ..write(obj.barcodeValueFormat)
      ..writeByte(15)
      ..write(obj.barcodeValueDisplayValue)
      ..writeByte(16)
      ..write(obj.barcodeValueRawValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarCodeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
