import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'consts/color.dart';
import 'core/db/hi_cache.dart';
import 'core/navigator/hi_route_delegate.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/widgets/login_input.dart';
import 'pages/widgets/appbar.dart';
import 'provider/theme_provider.dart';
import 'routes/route.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final MyRouteDelegate _routeDelegate = MyRouteDelegate();
  // final MyRouteInfoParser _routeInfoParser = MyRouteInfoParser();
  final HiRouteDelegate _routeDelegate = HiRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([HiCache.preInit()]), // 等待缓存初始化完成
      builder: (context, snapshot) {
        // 正在初始化：显示加载指示器
        Widget wdiget = Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );

        if (snapshot.connectionState == ConnectionState.done) {
          wdiget = Router(
            routerDelegate: _routeDelegate,
            // routerDelegate: _routeDelegate,
            // routeInformationParser: _routeInfoParser, //针对web可以不使用
            // routeInformationProvider: PlatformRouteInformationProvider(
            //   initialRouteInformation: RouteInformation(uri: Uri.parse('/')),
            // ),
          );
        }

        if (snapshot.hasError) {
          // 初始化失败：显示错误提示
          wdiget = Scaffold(
            body: Center(child: Text('初始化失败: ${snapshot.error}')),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: '我的B站',
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
                home: wdiget,
              );
            },
          ),
        );
      },
    );
  }
}
