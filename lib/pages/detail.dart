import 'package:flutter/material.dart';

import '../barrage/socket.dart';
import '../model/video_model.dart';
import 'detail_tab_page.dart';
import 'widgets/video_view.dart';

class Detail extends StatefulWidget {
  final VideoModel videoModel;
  Detail({Key? key, required this.videoModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  BarrageSocket? _barrageSocket;

  List tabs = ["简介", "评论"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _initSocket();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _barrageSocket?.close();
    super.dispose();
  }

  /// 初始化弹幕socket
  _initSocket() {
    _barrageSocket = BarrageSocket();
    _barrageSocket?.open(widget.videoModel.id.toString());
    _barrageSocket?.listen((list) {
      print('barrage: $list');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VideoView(videoUrl: widget.videoModel.videoUrl),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabBar(),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.live_tv_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((e) => DetailTabPage()).toList(),
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
