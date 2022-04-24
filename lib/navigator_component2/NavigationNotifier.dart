import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NavigationBarEvent { HOME, PROFIL }

class NavigationNotifier extends StateNotifier<PageModel> {
  NavigationNotifier() : super(defaultPage);

  static const defaultPage = PageModel(NavigationBarEvent.HOME);

  void selectPage(int i) {
    switch (i) {
      case 0:
        state = const PageModel(NavigationBarEvent.HOME);
        break;
      case 1:
        state = const PageModel(NavigationBarEvent.PROFIL);
        break;
    }
  }
}

class PageModel {
  const PageModel(this.page);
  final NavigationBarEvent page;
}
