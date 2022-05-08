import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/db_interface.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/scanner_form_details.dart';
import 'package:labels_scanner/camera_component/providers/providers_of_scanned_codes.dart';

class CompleteForm extends ConsumerStatefulWidget {
  const CompleteForm({Key? key, required this.scannedData}) : super(key: key);

  final BarcodeScannedDetails scannedData;

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
  bool _materialTypeHasError = false;

  var materialTypeOptions = ['Concrete', 'Steel', 'Tool'];

  String code_type = 'default';

  late bool isQrCode;

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
    Future.delayed(Duration.zero, () => ref.read(barcodesProvider));
    BarcodeScannedDetails _barcode = widget.scannedData;
    if (_barcode.barCodeData.barcodeValueFormat.toString().toLowerCase() ==
        'qrcode') {
      isQrCode = true;
    } else {
      isQrCode = false;
    }

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
                    initialValue:
                        widget.scannedData.scannerFormDetails?.appointmentTime,
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
                    firstDate: widget
                        .scannedData.scannerFormDetails!.firstDateDateRange,
                    lastDate: widget
                        .scannedData.scannerFormDetails!.lastDateDateRange,
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
                    initialValue:
                        widget.scannedData.scannerFormDetails!.numberOfThings,
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
                    initialValue: RangeValues(
                        widget.scannedData.scannerFormDetails!.firstPriceRange,
                        widget.scannedData.scannerFormDetails!.lastPriceRange),
                    divisions: 20000,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: const InputDecoration(labelText: 'Price Range'),
                  ),

                  FormBuilderDropdown<String>(
                    // autovalidate: true,
                    name: 'material_type',
                    initialValue:
                        widget.scannedData.scannerFormDetails!.materialType,
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
                    onPressed: () {
                      print('savinggggggggggg');
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                        Map<String, dynamic>? savedData =
                            _formKey.currentState?.value;
                        print(savedData?.keys);

                        var _scannerFormDetails = ScannerFormDetails(
                            appointmentTime: savedData!['appointment_time'],
                            firstDateDateRange:
                                (savedData['date_range'] as DateTimeRange)
                                    .start,
                            lastDateDateRange:
                                (savedData['date_range'] as DateTimeRange).end,
                            numberOfThings: savedData['number_of_things'],
                            firstPriceRange:
                                (savedData['price_range'] as RangeValues).start,
                            lastPriceRange:
                                (savedData['price_range'] as RangeValues).end,
                            materialType: savedData['material_type']);

                        _barcode.scannerFormDetails = _scannerFormDetails;

                        if (isQrCode) {
                          scannedQrcodesBox.put(_barcode.key, _barcode);
                        } else {
                          scannedBarcodesBox.put(_barcode.key, _barcode);
                        }
                        // save to hivedb because after saving the app might be destroyed

                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      /*
                   * after modifiyng restore all the form fields with the previouse item values
                   *
                   * */
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Restore Item',
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
