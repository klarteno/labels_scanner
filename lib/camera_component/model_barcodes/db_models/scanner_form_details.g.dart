// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_form_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannerFormDetailsAdapter extends TypeAdapter<ScannerFormDetails> {
  @override
  final int typeId = 1;

  @override
  ScannerFormDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannerFormDetails(
      appointmentTime: fields[2] as DateTime,
      firstDateDateRange: fields[3] as DateTime,
      lastDateDateRange: fields[4] as DateTime,
      numberOfThings: fields[5] as double,
      firstPriceRange: fields[6] as double,
      lastPriceRange: fields[7] as double,
      materialType: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScannerFormDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(2)
      ..write(obj.appointmentTime)
      ..writeByte(3)
      ..write(obj.firstDateDateRange)
      ..writeByte(4)
      ..write(obj.lastDateDateRange)
      ..writeByte(5)
      ..write(obj.numberOfThings)
      ..writeByte(6)
      ..write(obj.firstPriceRange)
      ..writeByte(7)
      ..write(obj.lastPriceRange)
      ..writeByte(8)
      ..write(obj.materialType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannerFormDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
