import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/notifications_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/qr_codes_screen.dart';
import 'package:labels_scanner/my_products/tags/tags.dart';
import 'package:labels_scanner/my_products/tags/view/tags_page.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome();

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
      if (_tabController.index == 0) {
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => TagsPage(key: _pageBarCodesKey2)));
                      //.push(MaterialPageRoute(builder: (_) => const AppTabsHome()));
                    },
                    child: const Icon(Icons.qr_code_scanner_outlined),
                  ),
                  Icon(Icons.search),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  Icon(Icons.more_vert)
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
              Tags(),
              Notifications(key: _pageNotificationsKey),
            ],
          ),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton(
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
