import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatefulWidget {
  final Widget? child;
  final double sigma;

  Blur({Key? key, this.child, this.sigma = 10}) : super(key: key);

  @override
  _BlurState createState() => _BlurState();
}

class _BlurState extends State<Blur> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: widget.sigma, sigmaY: widget.sigma),
      child: Container(color: Colors.white10, child: widget.child),
    );
  }
}
