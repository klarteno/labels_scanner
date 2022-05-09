import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/slidable_item.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/utils_slidable.dart';

import '../../../../camera_component/model_barcodes/db_models/barcode_scanned_details.dart';

class SlidableListScreen extends StatelessWidget {
  const SlidableListScreen(
      {Key? key,
      required this.boxScannedCodes,
      required this.boxScannedCodesDismissed})
      : super(key: key);

  final Box<BarcodeScannedDetails> boxScannedCodes;
  final Box<BarcodeScannedDetails> boxScannedCodesDismissed;

  @override
  Widget build(BuildContext context) {
    final Axis direction = AppState.of(context)!.direction;

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: boxScannedCodes.listenable(),
        builder: (context, Box<BarcodeScannedDetails> box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: flipAxis(direction),
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                BarcodeScannedDetails scannedData = currentBox.getAt(index)!;

                //ValueKey valueKey = ValueKey(scannedData.key.toString());

                return SlidableItem(
                    direction: direction,
                    scannedData: scannedData,
                    boxScannedCodes: boxScannedCodes,
                    boxScannedCodesDismissed: boxScannedCodesDismissed);

                /*
                return Slidable(
                  key: valueKey,
                  direction: direction,
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        boxScannedCodesDismissed.put(
                            scannedData.key, scannedData);
                        boxScannedCodes.delete(scannedData.key);
                      },
                      closeOnCancel: true,
                      confirmDismiss: () async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content:
                                      const Text('Are you sure to dismiss?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                      },
                    ),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          label: 'Dismiss',
                          icon: Icons.disabled_visible_outlined,
                          onPressed: (BuildContext context) {
                            boxScannedCodesDismissed.put(
                                scannedData.key, scannedData);
                            boxScannedCodes.delete(scannedData.key);
                          },
                          flex: 1),
                      /*
                      SlidableAction(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          label: 'Delete',
                          icon: Icons.delete,
                          onPressed: (BuildContext context) {},
                          flex: 1),
                      */
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Delete forever',
                          icon: Icons.delete_forever,
                          onPressed: (BuildContext context) {
                            boxScannedCodes.delete(scannedData.key);
                          },
                          flex: 2),
                      SlidableAction(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          label: 'Edit',
                          icon: Icons.edit_sharp,
                          onPressed: (_) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      UpdateScreen(scannedData: scannedData)),
                            );
                          },
                          flex: 1),
                    ],
                  ),
                  child: Tile(color: Colors.lime, text: nameLabel),
                );

  */
              },
            );
          }
        },
      ),
    );
  }
}
