import 'package:flutter/material.dart';

import '../../pages/detail.dart';
import '../../pages/home.dart';
import '../../pages/login.dart';
import '../../pages/register.dart';
import '../../pages/theme_page.dart';
import '../../pages/widgets/bottom_nav.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? prev);

MaterialPage<dynamic> pageWrap(Widget child, {String? name}) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child, name: name);
}

int getPageIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    if (getRouteStatus(pages[i]) == status) {
      return i;
    }
  }
  return -1;
}

//自定义路由封装，路由状态
enum RouteStatus { LOGIN, REGISTER, HOME, DETAIL, UNKNOWN, THEME }

//根据路由页面获取路由状态
RouteStatus getRouteStatus(MaterialPage page) {
  if (page.child is Login) {
    return RouteStatus.LOGIN;
  } else if (page.child is Register) {
    return RouteStatus.REGISTER;
  } else if (page.child is BottomNav) {
    return RouteStatus.HOME;
  } else if (page.child is Detail) {
    return RouteStatus.DETAIL;
  } else if (page.child is ThemePage) {
    return RouteStatus.THEME;
  } else {
    return RouteStatus.UNKNOWN;
  }
}

//路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo({required this.routeStatus, required this.page});
}

class HiNavigator extends _RouteJumpListener {
  HiNavigator._();

  RouteJumpListener? _routeJumpListener;

  //当前路由状态信息
  RouteStatusInfo? _current;

  //首页底部tab切换路由状态信息
  RouteStatusInfo? _bottomTab;
  
  //路由状态变化监听
  List<RouteChangeListener> _routeChangeListeners = [];

  static HiNavigator? _instance;
  static HiNavigator getInstance() {
    return _instance ??= HiNavigator._();
  }

  //添加路由状态变化监听
  void addListener(RouteChangeListener listener) {
    if (!_routeChangeListeners.contains(listener)) {
      _routeChangeListeners.add(listener);
    }
  }

  //移除路由状态变化监听
  void removeListener(RouteChangeListener listener) {
    _routeChangeListeners.remove(listener);
  }

  //通知路由状态变化
  void notifyRouteChange(List<MaterialPage> currentPages, List<MaterialPage> prevPages) {
    if (currentPages == prevPages) {
      return;
    }
    //当前打开的路由状态信息
    var current = RouteStatusInfo(routeStatus: getRouteStatus(currentPages.last), page: currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNav && _bottomTab != null) {
      //如果打开的是首页，明确到首页具体的tab
      current = _bottomTab!;
    }
    for (var listener in _routeChangeListeners) {
      listener(current, _current);
    }
    _current = current;
  }

  //首页底部tab切换监听
  void onBottomNavChange(int index, Widget page) {
    //首页底部tab切换路由状态信息
    _bottomTab = RouteStatusInfo(routeStatus: RouteStatus.HOME, page: page);
    //通知路由状态变化
    _notify(_bottomTab!);
  }

  //注册路由跳转
  void registerRouteJump(RouteJumpListener jump) {
    _routeJumpListener = jump;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener?.onJumpTo?.call(routeStatus, args: args);
  }
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteJumpListener {
  OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}

//路由跳转监听
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}
