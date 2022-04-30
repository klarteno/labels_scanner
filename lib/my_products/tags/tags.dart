import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/my_products/tags/view/tags_page.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Tags> {
  @override
  void initState() {
    super.initState();
    /*
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _loadDataAndNavigate();
    });*/
  }

  _loadDataAndNavigate() async {
    // fetch data | await this.service.fetch(x,y)
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TagsPage(key: PageStorageKey("bar_codes")),
    );
  }
}
