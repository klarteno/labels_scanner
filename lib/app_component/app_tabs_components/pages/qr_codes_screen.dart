import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/slidable_list_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/utils_slidable.dart';
import 'package:labels_scanner/camera_component/model_barcodes/db_models/db_interface.dart';

class QrCodes extends StatelessWidget {
  const QrCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppState(
      direction: Axis.horizontal,
      child: SlidableListScreen(
          boxScannedCodes: DbInterface.getDbQrcodesDisplay(),
          boxScannedCodesDismissed: DbInterface.getDbQrcodesDismissed()),
    );
  }
}
