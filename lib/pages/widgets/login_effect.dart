import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  bool protect;

  LoginEffect({Key? key, this.protect = false}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _image(),
      ),
    );
  }

  List<Image> _image() {
    var left = widget.protect
        ? 'assets/images/head_left_protect.png'
        : 'assets/images/head_left.png';
    var right = widget.protect
        ? 'assets/images/head_right_protect.png'
        : 'assets/images/head_right.png';

    return [
      Image.asset(left, fit: BoxFit.cover, height: 90),
      Image.asset('assets/images/logo.png', height: 90, width: 90),
      Image.asset(right, fit: BoxFit.cover, height: 90),
    ];
  }
}
