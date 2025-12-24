import 'package:flutter/material.dart';

import '../../core/navigator/hi_navigator.dart';
import '../favorite.dart';
import '../home.dart';
import '../my.dart';
import '../rank.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.pink[300];
  int _currentIndex = 0;
  static int _initialPage = 0;
  final PageController _pageController = PageController(
    initialPage: _initialPage,
  );
  late final List<Widget> _pages;
  bool _hasBuild = false;

  @override
  void initState() {
    super.initState();
    _pages = [
      Home(onJumpToBottomTab: (index) => _onJumpTo(index, pageChange: false)),
      Rank(),
      Favorite(),
      My(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasBuild) {
      _hasBuild = true;
      HiNavigator.getInstance().onBottomNavChange(
        _initialPage,
        _pages[_initialPage],
      );
    }

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: '排行榜'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '收藏'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: _activeColor,
        unselectedItemColor: _defaultColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _onJumpTo(index, pageChange: false),
      ),
    );
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      HiNavigator.getInstance().onBottomNavChange(index, _pages[index]);
    }

    setState(() {
      _currentIndex = index;
    });
  }
}
