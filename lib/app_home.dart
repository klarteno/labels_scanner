import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/pages/codes_searching.dart';
import 'package:labels_scanner/pages/qr_codes.dart';
import 'package:labels_scanner/pages/bar_codes.dart';

import 'camera_component/barcode_scanner_view.dart';

class AppHome extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const AppHome({this.cameras});

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Labels Scanner"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.camera_alt), height: 25),
            Tab(icon: Icon(CupertinoIcons.qrcode_viewfinder), height: 25),
            Tab(icon: Icon(CupertinoIcons.barcode_viewfinder), height: 25),
            Tab(icon: Icon(Icons.image_search_outlined), height: 25),
            //Tab(icon: Icon(CupertinoIcons.photo_on_rectangle)),
          ],
        ),
        actions: const <Widget>[
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          //CameraScreen(widget.cameras!),
          BarcodeScannerView(),
          QrCodes(),
          BarCodes(),
          CodesSearching(),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withGreen(12),
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => print("open chats"),
            )
          : null,
    );
  }
}
