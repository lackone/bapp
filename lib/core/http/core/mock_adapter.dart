//测试适配类

import '../request/base_request.dart';
import 'hi_net_adapter.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return HiNetResponse(
      statusCode: 555,
      statusMessage: "success",
      data: {"code": 0, "msg": "success"} as T,
    );
  }
}
