import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/db/hi_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 处理Flutter错误
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kReleaseMode) {
      // 在发布模式下，将错误上报到服务器
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    } else {
      // 在开发模式下，打印错误到控制台
      FlutterError.dumpErrorToConsole(details);
    }
  };
  runZonedGuarded(
    () {
      runApp(App());
    },
    (error, stackTrace) {
      print("error:$error");
      print("stackTrace:$stackTrace");
    },
  );
}
