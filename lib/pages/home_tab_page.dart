import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'video_card.dart';
import 'widgets/banner.dart';

class HomeTabPage extends StatefulWidget {
  String? name;

  HomeTabPage({Key? key, this.name}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          _banner(),
          Container(
            padding: EdgeInsets.all(5),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                VideoCard(name: '视频1'),
                VideoCard(name: '视频2'),
                VideoCard(name: '视频3'),
                VideoCard(name: '视频4'),
                VideoCard(name: '视频5'),
                VideoCard(name: '视频6'),
                VideoCard(name: '视频7'),
                VideoCard(name: '视频8'),
                VideoCard(name: '视频9'),
                VideoCard(name: '视频10'),
                VideoCard(name: '视频11'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return MyBanner(
      height: 100,
      images: [
        'assets/images/head_left.png',
        'assets/images/head_left.png',
        'assets/images/head_left.png',
      ],
    );
  }
}
