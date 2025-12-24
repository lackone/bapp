import 'package:bapp/core/db/hi_cache.dart';
import 'package:bapp/core/navigator/hi_navigator.dart';
import 'package:bapp/pages/home_tab_page.dart';
import 'package:flutter/material.dart';

import '../model/video_model.dart';
import 'widgets/top_nav.dart';

class Home extends StatefulWidget {
  ValueChanged<VideoModel>? onJumpToDetail;
  ValueChanged<int>? onJumpToBottomTab;

  Home({Key? key, this.onJumpToDetail, this.onJumpToBottomTab}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin, WidgetsBindingObserver {
  RouteChangeListener? listener;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];
  late TabController _tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    HiNavigator.getInstance().addListener(
      listener = (current, prev) {
        print("current: ${current.page}");
        print("prev: ${prev?.page}");
        if (widget == current.page && current.page is Home) {
          print("打开了首页");
        }
        if (widget == prev?.page && prev?.page is Home) {
          print("首页被压后台了");
        }
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
    _tabController.dispose();
    HiNavigator.getInstance().removeListener(listener!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("首页重新进入前台");
    }
    if (state == AppLifecycleState.paused) {
      print("首页被压后台了");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TopNav(
              color: Colors.white,
              statusStyle: StatusStyle.LIGHT_CONTENT,
              child: _appbar(),
            ),
            Container(color: Colors.white, child: _tabBar()),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((e) => HomeTabPage(name: e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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

  Widget _appbar() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              widget.onJumpToBottomTab?.call(3);
            },
            child: ClipOval(
              child: Image.asset(
                "assets/images/avatar.png",
                width: 32,
                height: 32,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 32,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
                  contentPadding: EdgeInsets.zero,
                  hintText: "搜索",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // 点击/聚焦后的边框 👈 关键！
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink[300]!,
                      width: 1,
                    ), // 更粗更显眼
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.explore_outlined, color: Colors.grey, size: 24),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {},
            child: Icon(Icons.mail_outlined, color: Colors.grey, size: 24),
          ),
        ],
      ),
    );
  }
}
