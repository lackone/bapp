import 'package:bapp/core/state/hi_tab_state.dart';
import 'package:flutter/material.dart';

import '../model/test.dart';

class RankTabPage extends StatefulWidget {
  RankTabPage({Key? key}) : super(key: key);

  @override
  _RankTabPageState createState() => _RankTabPageState();
}

class _RankTabPageState extends HiTabState<TestModel, TestModel, RankTabPage> {
  @override
  get contentChild => Container(
    padding: EdgeInsets.all(10),
    child: ListView.builder(
      controller: scrollController,
      itemCount: dataList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = dataList[index];
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
                          style: TextStyle(fontSize: 10, color: Colors.white),
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
                          "${item.name} 我是标题，这是一个很长的标题，我要显示在多行上,我是标题，这是一个很长的标题，我要显示在多行上",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.black),
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
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  );

  @override
  Future<TestModel> getData(int page) async {
    print('获取第$page页数据');
    return TestModel(id: page, name: '第$page页');
  }

  @override
  List<TestModel> parseList(TestModel result) {
    return List.generate(
      10,
      (index) =>
          TestModel(id: index, name: '第${(result.id - 1) * 10 + index + 1}'),
    );
  }
}
