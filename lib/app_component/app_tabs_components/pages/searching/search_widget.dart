import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/slidable_item.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/slidable_lists/utils_slidable.dart';

import '../../../../camera_component/model_barcodes/db_models/barcode_scanned_details.dart';

class SearchWidget extends SearchDelegate<BarcodeScannedDetails> {
  SearchWidget(
      {required this.boxScannedCodes, required this.boxScannedCodesDismissed});

  final Box<BarcodeScannedDetails> boxScannedCodes;
  final Box<BarcodeScannedDetails> boxScannedCodesDismissed;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            BarcodeScannedDetails
                .empty()); // for closing the search page anf going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return AppState(
      direction: Axis.horizontal,
      child: SearchFinder(
        query: query,
        boxScannedCodes: boxScannedCodes,
        boxScannedCodesDismissed: boxScannedCodesDismissed,
      ),
    );
  }

  /*

    return SearchFinder(
      query: query,
      boxScannedCodes: boxScannedCodes,
      boxScannedCodesDismissed: boxScannedCodesDismissed,
    );

  * */

  @override
  Widget buildSuggestions(BuildContext context) {
    return AppState(
      direction: Axis.horizontal,
      child: SearchFinder(
        query: query,
        boxScannedCodes: boxScannedCodes,
        boxScannedCodesDismissed: boxScannedCodesDismissed,
      ),
    );
  }
}

class SearchFinder extends StatelessWidget {
  const SearchFinder(
      {Key? key,
      required this.query,
      required this.boxScannedCodes,
      required this.boxScannedCodesDismissed})
      : super(key: key);

  final String query;
  final Box<BarcodeScannedDetails> boxScannedCodes;
  final Box<BarcodeScannedDetails> boxScannedCodesDismissed;

  @override
  Widget build(BuildContext context) {
    final Axis direction = AppState.of(context)!.direction;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: boxScannedCodes.listenable(),
        builder: (context, Box<BarcodeScannedDetails> box, _) {
          ///* this is where we filter data
          var results = query.isEmpty
              ? box.values.toList() // whole list
              : box.values
                  .where((c) => c.barCodeData.barcodeValueDisplayValue
                      .toLowerCase()
                      .contains(query))
                  .toList();

          return results.isEmpty
              ? Center(
                  child: Text(
                    'No results found !',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: flipAxis(direction),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    // passing as a custom list
                    final BarcodeScannedDetails barCodeListItem =
                        results[index];

                    return SlidableItem(
                        direction: direction,
                        scannedData: barCodeListItem,
                        boxScannedCodes: boxScannedCodes,
                        boxScannedCodesDismissed: boxScannedCodesDismissed);
                  },
                );
        },
      ),
    );
  }
}
