import 'package:flutter/material.dart';

import '../../consts/color.dart';

class LoginInput extends StatefulWidget {
  String title;
  String? hint;
  ValueChanged<String>? onChanged;
  ValueChanged<bool>? focusChange;
  bool? lineStretch;
  bool? obscureText;
  TextInputType? keyboardType;

  LoginInput({
    Key? key,
    required this.title,
    this.hint,
    this.onChanged,
    this.focusChange,
    this.lineStretch,
    this.obscureText,
    this.keyboardType,
  }) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      widget.focusChange?.call(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.only(left: 15),
                child: Text(widget.title, style: TextStyle(fontSize: 16)),
              ),
              Expanded(
                child: TextField(
                  cursorColor: primary,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText ?? false,
                  autofocus: !(widget.obscureText ?? false),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: widget.hint,
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: !(widget.lineStretch ?? false) ? 15 : 0,
            ),
            child: Container(height: 1, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
