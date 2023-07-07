// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:strongwave/main.dart';
import 'package:strongwave/view/navigator_page.dart';

import '../../view/mmoNews/mmo_news.dart';
import '../../view/valorantNews/valorantAllNews.dart';

class RouteManager {
  static const _appRouter = RouteManager._();

  const RouteManager._() : super();

  factory RouteManager.getInstance() {
    return _appRouter;
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.pageNavigator:
        return _route(
          () => const NavigatorPage(),
        );
      case RouteNames.valorantAllNews:
        return _route(
          () => const ValorantAllNews(),
        );
      case RouteNames.mmoNews:
        return _route(
          () => const MMONews(),
        );
      default:
        return _route(
          () => const MyApp(),
        );
    }
  }

  Route _route(
    Widget Function() widget,
  ) {
    return MaterialPageRoute(builder: (
      BuildContext builderContext,
    ) {
      return widget();
    });
  }
}

class RouteNames {
  static const String defaultRoute = '/';
  static const String valorantAllNews = '/valorantAllNews';
  static const String pageNavigator = '/page_navigator';
  static const String mmoNews = '/mmoNews';
}
