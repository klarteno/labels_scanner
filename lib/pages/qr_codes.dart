import 'package:flutter/material.dart';
import 'package:labels_scanner/my_products/tags/view/tags_page.dart';

class QrCodes extends StatefulWidget {
  const QrCodes({Key? key}) : super(key: key);

  @override
  QrCodesState createState() {
    return QrCodesState();
  }
}

class QrCodesState extends State<QrCodes> {
  @override
  Widget build(BuildContext context) {
    return const TagsPage();
  }
}
