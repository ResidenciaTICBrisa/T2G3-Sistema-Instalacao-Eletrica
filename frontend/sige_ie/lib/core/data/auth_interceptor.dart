import 'package:cookie_jar/cookie_jar.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  CookieJar cookieJar;

  AuthInterceptor(this.cookieJar);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var cookies = await cookieJar.loadForRequest(Uri.parse('http://10.0.2.2:8000/api/login/'));
    var sessionCookie;
    for (var cookie in cookies) {
      if (cookie.name == 'sessionid') {
        sessionCookie = cookie;
        break;
      }
    }
    if (sessionCookie != null) {
      data.headers.addAll({'Cookie': '${sessionCookie.name}=${sessionCookie.value}'});
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

