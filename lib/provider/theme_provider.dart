import 'package:bapp/core/db/hi_cache.dart';
import 'package:flutter/material.dart';

import '../consts/color.dart';
import '../consts/constants.dart';

extension ThemeProviderExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider with ChangeNotifier {
  ThemeMode? _themeMode;

  bool isDarkMode() => _themeMode == ThemeMode.dark;

  ThemeMode? getThemeMode() {
    String? theme = HiCache.getInstance().get(Constants.themeModeKey);
    switch (theme) {
      case 'Light':
        _themeMode = ThemeMode.light;
      case 'Dark':
        _themeMode = ThemeMode.dark;
      default:
        _themeMode = ThemeMode.system;
    }
    return _themeMode;
  }

  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    HiCache.getInstance().setString(Constants.themeModeKey, themeMode.value);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      tabBarTheme: TabBarThemeData(dividerColor: Colors.transparent), // 隐藏下划线
      colorScheme: ColorScheme(
        primary: isDarkMode ? HiColor.dark_bg : Colors.white,
        error: isDarkMode ? HiColor.dark_red : HiColor.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        secondary: isDarkMode ? primary[500]! : white,
        onPrimary: isDarkMode ? Colors.white : HiColor.dark_bg,
        onSecondary: isDarkMode ? HiColor.dark_red : HiColor.red,
        onError: isDarkMode ? Colors.white : HiColor.dark_bg,
        surface: isDarkMode ? HiColor.dark_bg : Colors.white,
        onSurface: isDarkMode ? Colors.white : HiColor.dark_bg,
      ),
    );
    return themeData;
  }
}
