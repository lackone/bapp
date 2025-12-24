import 'package:flutter/material.dart';

class DetailTabPage extends StatefulWidget {
  DetailTabPage({Key? key}) : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/avatar.png",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "用户昵称",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.pink[300],
                            ),
                          ),
                          Text(
                            "0粉丝",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("+ 关注", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      "这是一个用户的简介，介绍了用户的个人情况、爱好、经历等。",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: isExpanded ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 0,
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.live_tv_outlined, size: 12, color: Colors.grey),
              Text(
                "3028.46万",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(width: 10),
              Icon(Icons.comment_outlined, size: 12, color: Colors.grey),
              Text("3.46万", style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 10),
              Text("11-15", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.video_call_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text(
                      "3.07万",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 14, color: Colors.grey),
                    Text(
                      "3.07万",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text(
                      "3.07万",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Icon(Icons.share_outlined, size: 14, color: Colors.grey),
                    Text(
                      "3.07万",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Icon(
                      Icons.more_horiz_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text(
                      "更多",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // 阴影方向
                            ),
                          ],
                        ),
                        width: 140,
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/head_left.png",
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              right: 2,
                              bottom: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54.withAlpha(150),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  "11:15",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  "我是标题，这是一个很长的标题，我要显示在多行上,我是标题，这是一个很长的标题，我要显示在多行上",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.live_tv_outlined,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "乔峰",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.live_tv_outlined,
                                          size: 12,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "8.27万",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.question_answer_outlined,
                                          size: 12,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "699",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.more_horiz_outlined,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
