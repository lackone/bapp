import 'hi_error.dart';
import 'package:dio/dio.dart';

import '../request/base_request.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response;
    var error;
    var options = Options(headers: request.headers);

    try {
      // 发送请求
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          options.method = "GET";
          break;
        case HttpMethod.POST:
          options.method = "POST";
          break;
        case HttpMethod.PUT:
          options.method = "PUT";
          break;
        case HttpMethod.DELETE:
          options.method = "DELETE";
          break;
      }
      response = await Dio().request(
        request.url(),
        data: request.params,
        options: options,
      );
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw HiError(
        response.statusCode ?? -1,
        error.toString(),
        data: buildResponse<T>(response, request),
      );
    }

    return buildResponse<T>(response, request);
  }

  HiNetResponse<T> buildResponse<T>(Response res, BaseRequest request) {
    return HiNetResponse<T>(
      data: res.data,
      request: request,
      statusCode: res.statusCode,
      statusMessage: res.statusMessage,
    );
  }
}
