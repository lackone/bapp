import 'package:bapp/consts/color.dart';
import 'package:bapp/core/http/core/hi_error.dart';

import '../../common/toast.dart';
import 'hi_state.dart';
import 'package:flutter/material.dart';

//M为返回数据模型
//L为列表项模型
//T为具体的widget
abstract class HiTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int page = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();

  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var distance =
          scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (distance < 200 &&
          !loading &&
          //当列表高度不满屏幕高度时不执行加载更多
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: loadData,
      color: primary,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: contentChild,
      ),
    );
  }

  //获取对应页码的数据
  Future<M> getData(int page);
  //从数据模型中解析列表
  List<L> parseList(M result);

  Future<void> loadData({bool loadMore = false}) async {
    if (loading) {
      print('上次加载还没完成...');
      return;
    }
    print('loadData');
    loading = true;
    if (!loadMore) {
      page = 1;
    }
    var currentPage = page + (loadMore ? 1 : 0);
    try {
      var result = await getData(currentPage);

      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).isNotEmpty) {
            page++;
          }
        } else {
          dataList = parseList(result);
        }
      });

      Future.delayed(Duration(milliseconds: 500), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      showWarnToast(e.message);
    } on HiError catch (e) {
      loading = false;
      showWarnToast(e.message);
    }
  }
}
