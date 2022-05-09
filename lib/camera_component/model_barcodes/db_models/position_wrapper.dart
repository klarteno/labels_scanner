import 'package:hive_flutter/hive_flutter.dart';

part 'position_wrapper.g.dart';

@HiveType(typeId: 25)
class PositionData {
  PositionData({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.altitude,
    required this.horizontalAccuracy,
  });

  @HiveField(26)
  double latitude;

  @HiveField(27)
  double longitude;

  @HiveField(28)
  DateTime? timestamp;

  @HiveField(29)
  double altitude;

  @HiveField(30)
  final double horizontalAccuracy;
}
