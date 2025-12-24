import '../core/http/request/base_request.dart';

class RegRequest extends BaseRequest {
  @override
  String path() => "/uapi/user/registration";

  @override
  bool needLogin() => false;
  
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }
}