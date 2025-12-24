import 'package:flutter/material.dart';

import '../model/video_model.dart';
import '../pages/detail.dart';
import '../pages/home.dart';

/// 路由代理
class MyRouteDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  List<MaterialPage> pages = [];
  late MyRoutePath currentPath;
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    //路由堆栈
    pages = [
      pageWrap(Home(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners();
      })),
      if (videoModel != null) pageWrap(Detail(videoModel: videoModel!)),
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onDidRemovePage: (page) {
        pages.remove(page);
        notifyListeners();
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    currentPath = configuration;
  }
}

/// 路由信息解析器
class MyRouteInfoParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    print(uri);

    if (uri.pathSegments.isEmpty) {
      return MyRoutePath.home();
    }

    return MyRoutePath.detail();
  }
}

/// 路由路径
class MyRoutePath {
  final String location;

  MyRoutePath.home() : location = '/';

  MyRoutePath.detail() : location = '/detail';
}

MaterialPage<dynamic> pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
