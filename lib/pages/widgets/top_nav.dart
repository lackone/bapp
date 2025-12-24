import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class TopNav extends StatefulWidget {
  StatusStyle statusStyle;
  double height;
  Widget child;
  Color color;

  TopNav({
    Key? key,
    this.statusStyle = StatusStyle.LIGHT_CONTENT,
    this.height = 46,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _TopNavState createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height + top,
      decoration: BoxDecoration(color: widget.color),
      child: widget.child,
    );
  }
}
