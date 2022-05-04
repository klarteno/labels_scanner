// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'barcodes_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
//part 'barcodes_model.g.dart';

@freezed
class BarcodesDetails with _$BarcodesDetails {
  const factory BarcodesDetails({
    required String firstName,
    required String lastName,
    required int age,
  }) = _BarcodesDetails;
}
