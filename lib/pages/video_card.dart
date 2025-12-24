import 'package:bapp/core/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

import '../model/video_model.dart';

class VideoCard extends StatefulWidget {
  String? name;
  VideoCard({Key? key, this.name}) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    HiNavigator.getInstance().onJumpTo(
                      RouteStatus.DETAIL,
                      args: {'videoModel': VideoModel(id: 1, videoUrl: 'assets/videos/123.mp4')},
                    );
                  },
                  child: Image.asset(
                    'assets/images/head_left.png',
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.grey.withAlpha(80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.video_call,
                                size: 10,
                                color: Colors.white,
                              ),
                              Text(
                                '165.24万',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 10,
                                color: Colors.white,
                              ),
                              Text(
                                '1.54万',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                '4:34',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(widget.name ?? '', style: TextStyle(fontSize: 14)),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/head_left.png',
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(padding: EdgeInsets.only(left: 10), child: Text('张三')),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
