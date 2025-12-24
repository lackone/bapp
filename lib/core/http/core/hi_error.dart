class NeedLogin extends HiError {
  NeedLogin({int code = 401, String message = "需要登录", dynamic data}) : super(code, message, data: data);
}

class NeedAuth extends HiError {
  NeedAuth(String message, {int code = 403, dynamic data}) : super(code, message, data: data);
}

class HiError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiError(this.code, this.message, {this.data});

  @override
  String toString() {
    return 'HiError{code: $code, message: $message, data: ${data.toString()}}';
  }
}
