// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionDataAdapter extends TypeAdapter<PositionData> {
  @override
  final int typeId = 25;

  @override
  PositionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionData(
      latitude: fields[26] as double,
      longitude: fields[27] as double,
      timestamp: fields[28] as DateTime?,
      altitude: fields[29] as double,
      horizontalAccuracy: fields[30] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PositionData obj) {
    writer
      ..writeByte(5)
      ..writeByte(26)
      ..write(obj.latitude)
      ..writeByte(27)
      ..write(obj.longitude)
      ..writeByte(28)
      ..write(obj.timestamp)
      ..writeByte(29)
      ..write(obj.altitude)
      ..writeByte(30)
      ..write(obj.horizontalAccuracy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
