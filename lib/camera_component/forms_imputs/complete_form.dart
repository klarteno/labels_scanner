import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/db_interface.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/scanner_form_details.dart';
import 'package:labels_scanner/camera_component/model_barcodes/location_position.dart';
import 'package:labels_scanner/camera_component/providers/providers_of_scanned_codes.dart';
import 'package:snackbar_extension/snackbar_extension.dart';

class CompleteForm extends ConsumerStatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CompleteForm> createState() {
    return CompleteFormState();
  }
}

class CompleteFormState extends ConsumerState<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isQrCode = false;
  bool _materialTypeHasError = false;

  var materialTypeOptions = ['Concrete', 'Steel', 'Tool'];

  String code_type = 'default';
  String codeDisplayValue = '';

  void _onChanged(dynamic val) => debugPrint(val.toString());

  late final Box<BarcodeScannedDetails> scannedBarcodesBox;
  late final Box<BarcodeScannedDetails> scannedQrcodesBox;

  @override
  void initState() {
    scannedBarcodesBox = DbInterface.getDbBarcodesDisplay();
    scannedQrcodesBox = DbInterface.getDbQrcodesDisplay();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _barcode = ref.watch(barcodesProvider);
    var vert = Future.delayed(Duration.zero, () => ref.read(barcodesProvider));

    code_type = _barcode.barCodeData.barcodeValueFormat.toString();
    if (code_type == 'qrCode') {
      _isQrCode = true;
    } else {
      _isQrCode = false;
    }
    codeDisplayValue = _barcode.barCodeData.barcodeValueDisplayValue.toString();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              // enabled: false,
              autovalidateMode: AutovalidateMode.disabled,

              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  //var _barcode = ref.watch(barcodesProvider);
                  const SizedBox(height: 10),

                  FormBuilderDateTimePicker(
                    name: 'appointment_time',
                    initialValue: DateTime.now(),
                    inputType: InputType.time,
                    decoration: InputDecoration(
                      labelText: 'Appointment Time',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['date']
                                ?.didChange(null);
                          }),
                    ),
                    initialTime: const TimeOfDay(hour: 9, minute: 0),
                    locale: const Locale.fromSubtags(languageCode: 'en'),
                  ),

                  FormBuilderDateRangePicker(
                    name: 'date_range',
                    initialValue: DateTimeRange(
                        start: DateTime.now(), end: DateTime.now()),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    format: DateFormat('yyyy-MM-dd'),
                    initialEntryMode: DatePickerEntryMode.calendar,
                    onChanged: _onChanged,
                    decoration: InputDecoration(
                      labelText: 'Date Range Usage',
                      //helperText: 'Helper DateRange',
                      hintText: 'Input  Date Range Usage',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['date_range']
                                ?.didChange(null);
                          }),
                    ),
                  ),

                  FormBuilderSlider(
                    name: 'number_of_things',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(0.5),
                    ]),
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 30.0,
                    initialValue: 1.0,
                    divisions: 60,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(
                      labelText: 'Number of things',
                    ),
                  ),

                  FormBuilderRangeSlider(
                    name: 'price_range',
                    // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 10000.0,
                    initialValue: const RangeValues(400, 700),
                    divisions: 20000,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(labelText: 'Price Range'),
                  ),

                  FormBuilderDropdown<String>(
                    // autovalidate: true,
                    name: 'material_type',
                    initialValue: materialTypeOptions.first.toString(),
                    decoration:
                        const InputDecoration(labelText: 'Material Type'),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: const Text('Select Material Type'),
                    items: materialTypeOptions
                        .map((matType) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: matType,
                              child: Text(matType),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _materialTypeHasError = !(_formKey
                                .currentState?.fields['material_type']
                                ?.validate() ??
                            false);
                      });
                    },
                    valueTransformer: (val) => val?.toString(),
                  ),
                  /*FormBuilderRadioGroup<String>(
                    decoration: const InputDecoration(
                      labelText: 'My chosen language',
                    ),
                    initialValue: null,
                    name: 'best_language',
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text(lang),
                            ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                  ),*/
                  /* FormBuilderSegmentedControl(
                    decoration: const InputDecoration(
                      labelText: 'Movie Rating (Archer)',
                    ),
                    name: 'movie_rating',
                    // initialValue: 1,
                    // textStyle: TextStyle(fontWeight: FontWeight.bold),
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderFieldOption(
                              value: number,
                              child: Text(
                                number.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: _onChanged,
                  ),*/
                  /*
                  FormBuilderSwitch(
                    title: const Text('I Accept the terms and conditions'),
                    name: 'accept_terms_switch',
                    initialValue: true,
                    onChanged: _onChanged,
                  ),*/
                  /*
                  FormBuilderCheckboxGroup<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: 'The language of my people'),
                    name: 'languages',
                    // initialValue: const ['Dart'],
                    options: const [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: const VerticalDivider(
                      width: 10,
                      thickness: 5,
                      color: Colors.red,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1),
                      FormBuilderValidators.maxLength(3),
                    ]),
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      elevation: 10,
                      autofocus: true,
                      focusColor: Colors.indigo,
                      onPressed: () {
                        print('savinggggggggggg');

                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value.toString());
                          Map<String, dynamic>? savedData =
                              _formKey.currentState?.value;
                          print(savedData?.keys);
                          /*for (var key in (savedData?.keys)!) {
                          print(key.toString() + ' ');
                          print(savedData![key]);
                        }*/
                          var _scannerFormDetails = ScannerFormDetails(
                              appointmentTime: savedData!['appointment_time'],
                              firstDateDateRange:
                                  (savedData['date_range'] as DateTimeRange)
                                      .start,
                              lastDateDateRange:
                                  (savedData['date_range'] as DateTimeRange)
                                      .end,
                              numberOfThings: savedData['number_of_things'],
                              firstPriceRange:
                                  (savedData['price_range'] as RangeValues)
                                      .start,
                              lastPriceRange:
                                  (savedData['price_range'] as RangeValues).end,
                              materialType: savedData['material_type']);

                          _barcode.scannerFormDetails = _scannerFormDetails;

                          if (_barcode.barCodeData.barcodeValueFormat
                                  .toString()
                                  .toLowerCase() ==
                              'qrcode') {
                            LocationInterface.processScannedItem(
                                barcode: _barcode, box: scannedQrcodesBox);
                          } else {
                            LocationInterface.processScannedItem(
                                barcode: _barcode, box: scannedBarcodesBox);
                          }

                          SnackBarExtension.register(
                            name: "SavingConfirmation",
                            snackBar: const SnackBar(
                              content: Text("Save Complete"),
                            ),
                          );

                          SnackBarExtension.of(context, "SavingConfirmation")
                              .setContent(const Text("Saving Done"));

                          SnackBarExtension.of(context, "SavingConfirmation")
                              .setBackgroundColor(Colors.blue);
                          SnackBarExtension.of(context, "SavingConfirmation")
                              .setBehavior(SnackBarBehavior.floating);
                          SnackBarExtension.of(context, "SavingConfirmation")
                              .setDismissDirection(DismissDirection.down);

                          /* SnackBarExtension.of(context, "SavingConfirmation")
                            .show();
*/
                          SnackBarExtension.of(context, "SavingConfirmation")
                              .showTill(
                            content: const Text("Show Till Function"),
                            run: () async {
                              await Future.delayed(const Duration(seconds: 2));
                            },
                          );

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Saved Saved Saved Saved Saved Saved Saved')));
                          print('Saved Saved Saved Saved Saved Saved Saved');
                          print('Saved Saved Saved Saved Saved Saved Saved');

                          /*bool form_saved = true;
 when save make it true when completing form make it false and then:
  child: true? const Text(
                      'Saved',
                      style: TextStyle(color: Colors.white),
                    ):const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
 */

                          // save to hivedb because after saving the app might be destroyed
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      /* SnackBarExtension.register(
                        name: "ResetConfirmation",
                        snackBar: const SnackBar(
                          content: Text("Save Complete"),
                        ),
                      );*/
                      SnackBarExtension.of(context, "ResetConfirmation")
                          .setContent(const Text("Reset Done"));
                      SnackBarExtension.of(context, "ResetConfirmation")
                          .setBackgroundColor(Colors.black54);
                      SnackBarExtension.of(context, "ResetConfirmation")
                          .setBehavior(SnackBarBehavior.floating);
                      SnackBarExtension.of(context, "ResetConfirmation")
                          .setDismissDirection(DismissDirection.horizontal);
                      SnackBarExtension.of(context, "ResetConfirmation").show();

                      SnackBarExtension.of(context, "ResetConfirmation")
                          .showTill(
                        content: const Text("Show Till Function"),
                        run: () async {
                          await Future.delayed(const Duration(seconds: 2));
                        },
                      );
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
