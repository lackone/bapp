import '../core/db/hi_cache.dart';
import '../core/http/core/hi_net.dart';

import '../core/http/request/base_request.dart';
import '../request/login_request.dart';
import '../request/reg_request.dart';

class LoginDao {
  static const TOKEN = 'auth-token';

  static login(String username, String password) async {
    return _send(username, password);
  }

  static register(
    String username,
    String password,
    String imoocId,
    String orderId,
    String courseFlag,
  ) async {
    return _send(
      username,
      password,
      imoocId: imoocId,
      orderId: orderId,
      courseFlag: courseFlag,
    );
  }

  static _send(
    String username,
    String password, {
    imoocId,
    orderId,
    courseFlag,
  }) async {
    BaseRequest request;
    if (imoocId != null && orderId != null && courseFlag != null) {
      request = RegRequest();
    } else {
      request = LoginRequest();
    }
    request.add('username', username);
    request.add('password', password);
    request.add('imoocId', imoocId ?? '');
    request.add('orderId', orderId ?? '');
    request.add('courseFlag', courseFlag ?? '');

    var ret = await HiNet.getInstance().fire(request);
    
    if (ret['code'] == 0 && ret['data'] != null) {
      HiCache.getInstance().setString(TOKEN, ret['data']);
    }

    return ret;
  }

  static void setToken(String token) {
    HiCache.getInstance().setString(TOKEN, token);
  }

  static String getToken() {
    return HiCache.getInstance().get<String>(TOKEN) ?? "";
  }
}
