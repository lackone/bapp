import 'package:flutter/material.dart';

import 'rank_tab_page.dart';

class Rank extends StatefulWidget {
  Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> with SingleTickerProviderStateMixin {
  var tabs = ["最热", "最新", "收藏"];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: _tabBar(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((e) => RankTabPage()).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      tabAlignment: TabAlignment.center, // 调整对齐方式
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.pink[300],
      tabs: tabs.map((e) => Tab(text: e)).toList(),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.pink[300]!, width: 2.0),
      ),
    );
  }
}
