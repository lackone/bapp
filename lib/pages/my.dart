import 'package:bapp/core/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

import '../core/db/hi_cache.dart';
import 'widgets/banner.dart';
import 'widgets/blur.dart';
import 'widgets/flexible_header.dart';

class My extends StatefulWidget {
  My({Key? key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [_buildAppbar()],
        body: ListView(
          children: [
            _buildBanner(),
            _buildWork(),
            _buildService(),
            _buildTheme(),
            _buildExit(),
          ],
        ),
      ),
    );
  }

  Widget _buildTheme() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "主题模式",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
                  HiNavigator.getInstance().onJumpTo(RouteStatus.THEME);
                },
                child: Icon(Icons.wb_sunny, size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExit() {
    return ElevatedButton(
      onPressed: () {
        HiCache.getInstance().clear();
        HiNavigator.getInstance().onJumpTo(RouteStatus.LOGIN);
      },
      child: Text(
        "退出登录",
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }

  Widget _buildWork() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "职场进阶",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                "带你突破技术",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.lightGreen],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildService() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "增值服务",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                "购买后登录再次点击打开查看",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            childAspectRatio: 2 / 1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Flutter从基础到进阶",
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return MyBanner(
      height: 100,
      images: [
        'assets/images/head_left.png',
        'assets/images/head_left.png',
        'assets/images/head_left.png',
      ],
    );
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      expandedHeight: 160, // 展开高度
      //floating: true, // 当滚动到顶部时，是否显示AppBar
      pinned: true, // 固定在顶部
      //snap: true, // 当滚动到顶部时，是否立即显示AppBar
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, // 展开时，背景图片会有 parallax 效果
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildTitle(),
        background: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/head_left.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(child: Blur(sigma: 20)),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildTab()),
          ],
        ),
      ),
    );
  }

  Widget _buildTab() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.favorite_outline, size: 14, color: Colors.black54),
              Text('收藏', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.star_border_outlined, size: 14, color: Colors.black54),
              Text('点赞', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.looks_4_outlined, size: 14, color: Colors.black54),
              Text('浏览', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.money_outlined, size: 14, color: Colors.black54),
              Text('金币', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.face_2_outlined, size: 14, color: Colors.black54),
              Text('粉丝', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return FlexibleHeader(
      name: 'My',
      face: 'assets/images/head_left.png',
      scrollController: _scrollController,
    );
  }
}
