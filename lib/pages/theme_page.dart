import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("夜间主题")),
      body: Container(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).setTheme(ThemeMode.system);
              },
              child: ListTile(title: Text("系统")),
            ),
            InkWell(
              onTap: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).setTheme(ThemeMode.dark);
              },
              child: ListTile(title: Text("开启")),
            ),
            InkWell(
              onTap: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).setTheme(ThemeMode.light);
              },
              child: ListTile(title: Text("关闭")),
            ),
          ],
        ),
      ),
    );
  }
}
