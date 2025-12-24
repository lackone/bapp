//统一处理网络请求
import 'dart:convert';

import '../request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

// 网络层返回格式
class HiNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;

  HiNetResponse({this.data, this.request, this.statusCode, this.statusMessage});

  @override
  String toString() {
    if (data is Map || data is List) {
      return jsonEncode(data);
    }
    return data.toString();
  }
}
