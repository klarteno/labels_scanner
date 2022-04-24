import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'NavigationNotifier.dart';

final provider = StateNotifierProvider((ref) => NavigationNotifier());

class NavigationBarScreen extends HookConsumerWidget {
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.purpleAccent, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              fixedColor: Colors.teal,
              unselectedItemColor: Colors.cyan,
              currentIndex: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: ref.read(provider.notifier).selectPage,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  activeIcon: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  activeIcon: Text('Settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
