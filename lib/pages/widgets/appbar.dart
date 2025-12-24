import 'package:flutter/material.dart';

AppBar appbar(
  String title, {
  String? rightTitle,
  Function()? rightButtonClick,
}) {
  return AppBar(
    backgroundColor: Colors.white, // 背景颜色
    surfaceTintColor: Colors.transparent, // 取消默认的白色背景
    centerTitle: false,
    titleSpacing: 0,
    elevation: 2, // 设置阴影高度（默认在某些主题下可能为 0）
    shadowColor: Colors.black, // 阴影颜色（可选）
    leading: BackButton(),
    title: Text(title, style: TextStyle(color: Colors.black, fontSize: 18)),
    actions: [
      InkWell(
        onTap: rightButtonClick ?? () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle ?? "",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ),
    ],
  );
}
