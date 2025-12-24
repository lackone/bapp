import 'hi_net_adapter.dart';
import 'mock_adapter.dart';

import '../request/base_request.dart';
import 'dio_adapter.dart';
import 'hi_error.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;

  static HiNet getInstance() {
    return _instance ??= HiNet._();
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    var ret;
    var code;

    try {
      response = await send(request);
    } on HiError catch (e) {
      // 自定义异常
      error = e;
      response = e.data;
    } catch (e) {
      // 其他异常
      error = e;
      pLog(e.toString());
    }

    ret = response?.data;
    code = response?.statusCode;
    
    switch (code) {
      case 200:
        break;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(error.message, data: ret);
      default:
        throw HiError(code, error.message, data: ret);
    }

    return ret;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    pLog('url: ${request.url()}');
    pLog('method: ${request.httpMethod()}');
    pLog('params: ${request.params}');
    pLog('headers: ${request.headers}');

    // var adapter = MockAdapter();
    var adapter = DioAdapter();
    return adapter.send(request);
  }

  void pLog(dynamic log) {
    print('HttpNet: ${log.toString()}');
  }
}
