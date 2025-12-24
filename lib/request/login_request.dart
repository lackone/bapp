import '../core/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  String path() => "/uapi/user/login";

  @override
  bool needLogin() => false;
  
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }
}