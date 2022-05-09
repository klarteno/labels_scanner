import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/position_wrapper.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationInterface {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.storage,
    ].request();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest);
  }

  static void processScannedItem(
      {required BarcodeScannedDetails barcode,
      required Box<BarcodeScannedDetails> box}) async {
    Position? position;

    try {
      position = await _determinePosition();

      barcode.positionData = PositionData(
          latitude: position!.latitude,
          longitude: position.longitude,
          timestamp: position.timestamp,
          altitude: position.altitude,
          horizontalAccuracy: position.accuracy);

      print('position.toString()');
      print(position.toString());
      print(position.toJson());
      print('position.toString()');
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
    } finally {
      await box.put(barcode.key, barcode);
    }
  }
}
