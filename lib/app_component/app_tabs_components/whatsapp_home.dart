import 'package:flutter/material.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/bar_codes_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/notifications_screen.dart';
import 'package:labels_scanner/app_component/app_tabs_components/pages/qr_codes_screen.dart';

class WhatsAppHome extends StatefulWidget {
  WhatsAppHome();

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFab = true;
  int _selectedIndex = 0;

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
                  tabs: const <Widget>[
                    Tab(text: "Qr Codes"),
                    Tab(text: "Bar Codes"),
                    Tab(text: "Notifications"),
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
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              QrCodes(),
              BarCodes(),
              Notifications(),
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
