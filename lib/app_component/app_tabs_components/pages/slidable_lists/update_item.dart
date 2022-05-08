import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/complete_form.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/barcode_scanned_details.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key, required this.scannedData}) : super(key: key);

  final BarcodeScannedDetails scannedData;

  @override
  Widget build(BuildContext context) {
    print(scannedData.barCodeData.toString());
    print(scannedData.scannerFormDetails.toString());

    return MaterialApp(
      highContrastTheme: ThemeData.dark(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        body: Material(
          key: ValueKey('edit_barcode_form'),
          child: CompleteForm(scannedData: scannedData),
        ),
        appBar: AppBar(
          title: const Text('Edit Item'),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    /* onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              // builder: (_) => const BarCodeScannerView()),
                              builder: (_) =>
                                  const ProviderScope(child: AppTabsHome())),
                        ),*/
                    child: const Icon(
                        Icons.arrow_back_rounded // .app_shortcut_rounded
                        ))),
          ],
        ),
      ),
    );
  }
}
