import 'package:riverpod_navigator/riverpod_navigator.dart';

class HomeComponentsTabsSegment extends TypedSegment {
  const HomeComponentsTabsSegment();
  // ignore: avoid_unused_constructor_parameters
  factory HomeComponentsTabsSegment.decode(UrlPars pars) =>
      const HomeComponentsTabsSegment();
}

class AppComponentsTabSegment extends TypedSegment {
  const AppComponentsTabSegment();
  // ignore: avoid_unused_constructor_parameters
  factory AppComponentsTabSegment.decode(UrlPars pars) =>
      const AppComponentsTabSegment();
}

class BarCodesSegment extends TypedSegment {
  const BarCodesSegment({required this.id});
  factory BarCodesSegment.decode(UrlPars pars) =>
      BarCodesSegment(id: pars.getInt('id'));
  final int id;

  @override
  void encode(UrlPars pars) => pars.setInt('id', id);
}

class QrCodesSegment extends TypedSegment {
  const QrCodesSegment({required this.id});
  factory QrCodesSegment.decode(UrlPars pars) =>
      QrCodesSegment(id: pars.getInt('id'));
  final int id;

  @override
  void encode(UrlPars pars) => pars.setInt('id', id);
}

class CodesSearchingSegment extends TypedSegment {
  const CodesSearchingSegment();
  // ignore: avoid_unused_constructor_parameters
  factory CodesSearchingSegment.decode(UrlPars pars) =>
      const CodesSearchingSegment();
}
