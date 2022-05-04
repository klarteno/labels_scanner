import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/riverpod_list_items.dart';

class BarCodes extends StatelessWidget {
  const BarCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const TagsPage();
    return const RiverpodListitems();
  }
}
