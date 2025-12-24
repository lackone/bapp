enum HttpMethod { GET, POST, PUT, DELETE }

abstract class BaseRequest {
  // curl -X GET "http://localhost:8080/api/hello?name=张三"
  // curl -X POST "http://localhost:8080/api/hello/name/张三"
  // 要支持 queryParmas 和 pathParams
  var pathParams;
  var useHttps = true;
  Map<String, String> params = {};
  Map<String, dynamic> headers = {
    'course-flag' : 'ft',
    'auth-token' : 'MjAyMC0wNi0yMyAwMzoyNTowMQ==fa',
  };

  String authority() {
    return 'api.devio.org';
  }

  // 定义http方法
  HttpMethod httpMethod();

  // 定义路径
  String path(); // /api/hello

  // 是否需要登录
  bool needLogin();

  // 生成url
  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (pathStr.endsWith('/')) {
        pathStr = "$pathStr$pathParams";
      } else {
        pathStr = "$pathStr/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    return uri.toString();
  }

  // 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 添加header
  BaseRequest addHeader(String k, Object v) {
    headers[k] = v;
    return this;
  }
}
