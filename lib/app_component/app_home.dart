import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labels_scanner/camera_component/barcode_scanner_view.dart';
import 'package:labels_scanner/my_products/tags/view/tags_page.dart';
import 'package:labels_scanner/pages/bar_codes.dart';
import 'package:labels_scanner/pages/codes_searching.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

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
        toolbarHeight: 28,
        shadowColor: Colors.deepPurpleAccent,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          null,
          0,
        ),
        bottom: TabBar(
          labelColor: Colors.lightGreenAccent,
          overlayColor: MaterialStateProperty.all<Color?>(
            Colors.indigo,
          ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => null,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => null,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          //CameraScreen(widget.cameras!),
          Center(
            child: BarCodeScannerView(),
          ),
          Center(
            child: TagsPage(),
          ),
          Center(
            child: BarCodes(),
          ),
          Center(
            child: CodesSearching(),
          ),
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
              onPressed: () => print("open lists of.."),
            )
          : null,
    );
  }
}
