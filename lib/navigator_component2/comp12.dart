import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Index extends StateNotifier<int> {
  Index() : super(0);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => Index());

class Home12 extends ConsumerWidget {
  static const route = '/home';
  const Home12({Key? key}) : super(key: key);

  final List<Widget> fragments = const [
    Text('Page 1'),
    Text('Page 2'),
    Text('Page 3')
  ];

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
    BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
  ];

  final Text title = const Text('My App');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController();
    final int menuIndex = ref.watch(indexProvider) as int;

    return Scaffold(
      appBar: AppBar(title: title, actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.list))
      ]),
      body: PageView(
          controller: controller,
          children: fragments,
          onPageChanged: (i) => ref.read(indexProvider.notifier).value = i),
      bottomNavigationBar: BottomNavigationBar(
          items: navItems,
          currentIndex: menuIndex,
          onTap: (i) {
            ref.read(indexProvider.notifier).value = i;
            controller.animateToPage(i,
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
          }),
    );
  }
}
