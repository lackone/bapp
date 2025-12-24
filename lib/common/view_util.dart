import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 缓存网络图片
Widget cacheImage(String url, {double width = 0, double height = 0}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
