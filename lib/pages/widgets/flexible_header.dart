import 'package:flutter/material.dart';

class FlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController scrollController;

  FlexibleHeader({
    Key? key,
    required this.name,
    required this.face,
    required this.scrollController,
  }) : super(key: key);

  @override
  _FlexibleHeaderState createState() => _FlexibleHeaderState();
}

class _FlexibleHeaderState extends State<FlexibleHeader> {
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;
  static const MAX_OFFSET = 80;
  double _bottom = MAX_BOTTOM;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      var offset = widget.scrollController.offset;
      var dyoffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      var dy = dyoffset * (MAX_BOTTOM - MIN_BOTTOM);
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        _bottom = MIN_BOTTOM + dy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 10, bottom: _bottom),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              widget.face,
              fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(width: 10),
          Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
