import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/bar_codes_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/notifications_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/qr_codes_screen.dart';
import 'package:labels_scanner/camera_component/barcode_scanner_view.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({Key? key}) : super(key: key);

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFab = true;
  int _selectedIndex = 0;
  final _pageQrCodesKey = const PageStorageKey("qr_codes");
  final _pageBarCodesKey2 = const PageStorageKey("bar_codes2");
  final _pageNotificationsKey = const PageStorageKey("notifications_codes");

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 2) {
        showFab = true;
      } else {
        showFab = false;
      }
      //  _tabController.animateTo(_selectedIndex += 1);
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Scanner App'),
                pinned: true,
                floating: true,
                elevation: 0.7,
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.white,

                  /*tabs: Stack(
                    children: const [
                      Offstage(child: Tab(text: "Qr Codes")),
                      Offstage(child: Tab(text: "Bar Codes")),
                      Offstage(child: Tab(text: "Notifications")),
                    ],
                  ).children,*/

                  tabs: const <Widget>[
                    Tab(text: "Qr Codes"),
                    Tab(text: "Bar Codes"),
                    Tab(text: "Notifications"),
                  ],
                ),
                actions: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            // builder: (_) => const BarCodeScannerView()),
                            builder: (_) => const ProviderScope(
                                child: BarCodeScannerView())),
                      );
                    },
                    child: const Icon(Icons.qr_code_scanner_outlined),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                  ),
                  const Icon(Icons.search),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                  ),
                  const Icon(Icons.more_vert)
                ],
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            /*children: Stack(
              children: [
                Offstage(child: QrCodes(key: _pageQrCodesKey)),
                Offstage(child: TagsPage(key: _pageBarCodesKey)),
                Offstage(child: Notifications(key: _pageNotificationsKey)),
              ],
            ).children,*/

            children: <Widget>[
              QrCodes(key: _pageQrCodesKey),
              //TagsPage(key: _pageBarCodesKey),
              //Tags(),
              BarCodes(key: _pageBarCodesKey2),
              Notifications(key: _pageNotificationsKey),
            ],
          ),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Theme.of(context).accentColor,
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                onPressed: () => print("open chats"),
              )
            : null,
      ),
    );
  }
}
