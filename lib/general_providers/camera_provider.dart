import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/classes/mobile_cameras_data.dart';

final _mobileCamerasProvider = FutureProvider<List<CameraDescription>>(
    (_) async => await availableCameras());

final mobileCamerasPrefsDataProvider =
    StateNotifierProvider<MobileCamerasDataNotifier, MobileCamerasData?>((ref) {
  final pref = ref
      .watch(_mobileCamerasProvider)
      .maybeWhen(data: (prefs) => prefs, orElse: () => null);
  return MobileCamerasDataNotifier(pref);
});

class MobileCamerasDataNotifier extends StateNotifier<MobileCamerasData?> {
  MobileCamerasDataNotifier(List<CameraDescription>? pref)
      : _pref = pref,
        super(null) {
    _fetchAll();
  }

  final List<CameraDescription>? _pref;

  //
  // Initial fetch
  //

  void _fetchAll() {
    if (_pref == null) {
      state = null;
      return;
    }
    state = MobileCamerasData(mobileCameras: _pref);
  }
}
