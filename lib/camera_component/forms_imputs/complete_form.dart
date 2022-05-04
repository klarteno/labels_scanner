import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class CompleteForm extends StatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  CompleteFormState createState() {
    return CompleteFormState();
  }
}

class CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _materialTypeHasError = false;

  var materialTypeOptions = ['Concrete', 'Steel', 'Tool'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 10),
                  FormBuilderDateTimePicker(
                    name: 'date',
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
                    name: 'slider',
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
                    name: 'range_slider',
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
                  /* FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'age',
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError = !(_formKey.currentState?.fields['age']
                                ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ]),
                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderDropdown<String>(
                    // autovalidate: true,
                    name: 'material_type',
                    decoration: InputDecoration(
                      labelText: 'Material Type',
                      suffix: _materialTypeHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: const Text('Select Material Type'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
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
                  ),*/
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
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState?.value.toString());
                        Map<String, dynamic>? savedData =
                            _formKey.currentState?.value;
                        //print(savedData?.keys);
                        for (var key in (savedData?.keys)!) {
                          print(key.toString() + ' ');
                          print(savedData![key]);
                        }
                        //List<Barcode> barcodes_found = widget.barcodesToStore;
                        //print(barcodes_found.toString());
                      } else {
                        //debugPrint(_formKey.currentState?.value.toString());
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
