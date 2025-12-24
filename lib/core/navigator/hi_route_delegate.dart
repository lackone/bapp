import 'package:flutter/material.dart';

import '../../dao/login_dao.dart';
import '../../model/video_model.dart';
import '../../pages/home.dart';
import '../../pages/detail.dart';
import '../../pages/login.dart';
import '../../pages/register.dart';
import '../../pages/theme_page.dart';
import '../../pages/widgets/bottom_nav.dart';
import 'hi_navigator.dart';
import 'hi_route_path.dart';

class HiRouteDelegate extends RouterDelegate<HiRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RouteStatus _routeStatus = RouteStatus.HOME;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  HiRouteDelegate() {
    HiNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.DETAIL) {
            videoModel = args?['videoModel'] as VideoModel?;
          }
          notifyListeners();
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    //如果不是注册页，且未登录，则返回登录页
    if (_routeStatus != RouteStatus.REGISTER && !hasLogin) {
      return RouteStatus.LOGIN;
    } else if (_routeStatus == RouteStatus.DETAIL && videoModel != null) {
      return RouteStatus.DETAIL;
    }
    //其他情况，返回当前路由状态
    return _routeStatus;
  }

  bool get hasLogin {
    //return LoginDao.login() != null;
    return LoginDao.getToken().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tmpPages = pages;
    //如果路由状态存在于路由堆栈中
    if (index != -1) {
      //将路由状态之前的页面保留在路由堆栈中
      tmpPages = tmpPages.sublist(0, index);
    }

    var page;
    //因为是首页，不能回退到其他页面
    if (routeStatus == RouteStatus.HOME) {
      pages.clear();
      page = pageWrap(
        BottomNav(),
        name: 'home',
        // Home(
        //   onJumpToDetail: (VideoModel model) {
        //     videoModel = model;
        //     notifyListeners();
        //   },
        // ),
      );
    } else if (routeStatus == RouteStatus.DETAIL) {
      page = pageWrap(Detail(videoModel: videoModel!), name: 'detail');
    } else if (routeStatus == RouteStatus.REGISTER) {
      page = pageWrap(
        Register(),
        name: 'register',
        // Register(
        //   onJumpToLogin: () {
        //     _routeStatus = RouteStatus.LOGIN;
        //     notifyListeners();
        //   },
        //   onSuccess: () {
        //     _routeStatus = RouteStatus.LOGIN;
        //     notifyListeners();
        //   },
        // ),
      );
    } else if (routeStatus == RouteStatus.LOGIN) {
      page = pageWrap(
        Login(),
        name: 'login',
        // Login(
        //   onJumpToRegister: () {
        //     _routeStatus = RouteStatus.REGISTER;
        //     notifyListeners();
        //   },
        //   onSuccess: () {
        //     _routeStatus = RouteStatus.HOME;
        //     notifyListeners();
        //   },
        // ),
      );
    } else if (routeStatus == RouteStatus.THEME) {
      page = pageWrap(ThemePage(), name: 'theme');
    }

    //路由堆栈
    tmpPages = [...tmpPages, page];

    //通知路由状态变化
    HiNavigator.getInstance().notifyRouteChange(tmpPages, pages);

    pages = tmpPages;

    return PopScope(
      canPop: navigatorKey.currentState?.canPop() ?? false,
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onDidRemovePage: (page) {
          var tmpPages = [...pages]; //变化之前的
          pages.remove(page); //变化之后的
          //通知路由状态变化
          HiNavigator.getInstance().notifyRouteChange(pages, tmpPages);
          //notifyListeners(); //这里要去掉
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(HiRoutePath configuration) async {}
}
