import 'package:cookie_jar/cookie_jar.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';

class AuthInterceptor implements InterceptorContract {
  CookieJar cookieJar;

  AuthInterceptor(this.cookieJar);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var cookies =
        await cookieJar.loadForRequest(Uri.parse('$urlUniversal/api/login/'));
    Cookie? sessionCookie;
    for (var cookie in cookies) {
      if (cookie.name == 'sessionid') {
        sessionCookie = cookie;
        break;
      }
    }
    data.headers
        .addAll({'Cookie': '${sessionCookie!.name}=${sessionCookie.value}'});
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
