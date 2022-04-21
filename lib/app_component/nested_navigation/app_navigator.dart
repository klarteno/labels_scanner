import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labels_scanner/app_component/nested_navigation/models/TypedSegment.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/bar_codes_screen.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/codes_searching_screen.dart';
import 'package:labels_scanner/app_component/nested_navigation/home_components_tabs_screen.dart';
import 'package:labels_scanner/app_component/nested_navigation/screens/qr_codes_screen.dart';
import 'package:riverpod_navigator/riverpod_navigator.dart';

import 'app_components_tab.dart';

class AppNavigator extends RNavigator {
  /// Constructor for Qr Codes nested navigator.
  AppNavigator.forQrCodes(Ref ref)
      : super(
          ref,
          [
            RRoute<QrCodesSegment>(
              'Qr Code',
              QrCodesSegment.decode,
              QrCodesScreen.new,
            ),
          ],
        );

  /// constructor for Bar Codes nested navigator
  AppNavigator.forBarCodes(Ref ref)
      : super(
          ref,
          [
            RRoute<BarCodesSegment>(
              'Bar Code',
              BarCodesSegment.decode,
              BarCodesScreen.new,
            ),
          ],
        );

  /// constructor for Codes Searching nested navigator
  AppNavigator.forCodesSearching(Ref ref)
      : super(
          ref,
          [
            RRoute<CodesSearchingSegment>(
              'Bar Code',
              CodesSearchingSegment.decode,
              CodesSearchingScreen.new,
            ),
          ],
        );

  // ignore: sort_unnamed_constructors_first
  AppNavigator(Ref ref)
      : super(
          ref,
          [
            RRoute<HomeComponentsTabsSegment>(
              'Home Components Tabs',
              HomeComponentsTabsSegment.decode,
              HomeComponentsTabsScreen.new,
            ),
            RRoute<AppComponentsTabSegment>(
              'App Components Tabs',
              AppComponentsTabSegment.decode,
              AppComponentsTab.new,
            ),
            RRoute<BarCodesSegment>(
              'Bar Codes',
              BarCodesSegment.decode,
              BarCodesScreen.new,
            ),
            RRoute<QrCodesSegment>(
              'Qr Codes',
              QrCodesSegment.decode,
              QrCodesScreen.new,
            ),
            RRoute<CodesSearchingSegment>(
              'Codes Searching',
              CodesSearchingSegment.decode,
              CodesSearchingScreen.new,
            ),
          ],
          progressIndicatorBuilder: () =>
              const SpinKitCircle(color: Colors.blue, size: 45),
        );

  // ******* actions used on the screens
  Future toQrCode() => replaceLast<QrCodesSegment>((actualQrCode) =>
      QrCodesSegment(id: actualQrCode.id == 5 ? 1 : actualQrCode.id + 1));

  Future toBarCodes() => replaceLast<BarCodesSegment>((actualAuthor) =>
      BarCodesSegment(id: actualAuthor.id == 5 ? 1 : actualAuthor.id + 1));
}
