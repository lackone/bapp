import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

import '../../core/navigator/hi_navigator.dart';
import '../../model/video_model.dart';

class MyBanner extends StatefulWidget {
  final double height;
  final List<String> images;

  MyBanner({Key? key, this.height = 100, required this.images})
    : super(key: key);

  @override
  _MyBannerState createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(height: widget.height, child: _banner());
  }

  Widget _banner() {
    return Swiper(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            HiNavigator.getInstance().onJumpTo(
              RouteStatus.DETAIL,
              args: {'videoModel': VideoModel(id: index)},
            );
          },
          child: Image.asset(widget.images[index], fit: BoxFit.fitHeight),
        );
      },
      itemCount: widget.images.length,
      autoplay: true,
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        builder: DotSwiperPaginationBuilder(
          color: Colors.grey,
          activeColor: Colors.pink[300],
          size: 5.0,
          activeSize: 5.0,
        ),
      ),
    );
  }
}
