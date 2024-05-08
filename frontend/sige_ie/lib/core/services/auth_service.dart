import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/services/auth_interceptor.dart';
import 'package:sige_ie/main.dart';

class AuthService {
  static Future<String> fetchCsrfToken() async {
    const String url = 'http://10.0.2.2:8000/api/csrfcookie/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String cookie = response.headers['set-cookie']!;
      String csrfToken = cookie.split(';')[0].substring('csrftoken='.length);

      final csrfCookie = Cookie('csrftoken', csrfToken);
      cookieJar.saveFromResponse(
          Uri.parse('http://10.0.2.2:8000/api/csrftoken/'), [csrfCookie]);

      return csrfToken;
    } else {
      throw Exception('Falha ao obter o token CSRF: ${response.statusCode}');
    }
  }

  static Future<String> fetchSessionCookie() async {
    const url = 'http://10.0.2.2:8000/api/sessioncookie/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final cookies = response.headers['set-cookie']?.split(',');

      String? sessionid;
      if (cookies != null) {
        for (var cookie in cookies) {
          if (cookie.contains('sessionid')) {
            sessionid = cookie.split(';')[0].split('=')[1];
            break;
          }
        }
      }
      return sessionid!;
    } else {
      throw Exception('Failed to fetch session cookie: ${response.statusCode}');
    }
  }

  Future<bool> checkAuthenticated() async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    final response =
        await client.get(Uri.parse('http://10.0.2.2:8000/api/checkauth/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['isAuthenticated'];
    } else {
      throw Exception('Failed to check authentication');
    }
  }

  Future<bool> login(String username, String password) async {
    //var csrfToken = await fetchCsrfToken();
    //print(csrfToken);

    var url = Uri.parse('http://10.0.2.2:8000/api/login/');

    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
          }));
      final cookies = response.headers['set-cookie']?.split(',');

      String? sessionid;
      if (cookies != null) {
        for (var cookie in cookies) {
          if (cookie.contains('sessionid')) {
            sessionid = cookie.split(';')[0].split('=')[1];
            break;
          }
        }
      }

      final cookie = Cookie('sessionid', sessionid!);
      cookieJar.saveFromResponse(
          Uri.parse('http://10.0.2.2:8000/api/login/'), [cookie]);

      if (response.statusCode == 200) {
        //print("Login bem-sucedido: $data");
        return true;
      } else {
        //print("Falha no login: ${response.body}");
        return false;
      }
    } catch (e) {
      //print("Erro ao tentar fazer login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    //final cookies = await cookieJar.loadForRequest(Uri.parse('http://10.0.2.2:8000/api/csrftoken/'));

    var url = Uri.parse('http://10.0.2.2:8000/api/logout/');

    try {
      var client =
          InterceptedClient.build(interceptors: [AuthInterceptor(cookieJar)]);
      var response =
          await client.post(url, headers: {'Content-Type': 'application/json'});
      cookieJar.deleteAll();
      if (response.statusCode == 200) {
        //print("Logout bem-sucedido");
      } else {
        //print("Falha no logout: ${response.body}");
        //bool isAuth = await checkAuthenticated();
        //print(isAuth);
      }
    } catch (e) {
      //print("Erro ao tentar fazer logout: $e");
    }
  }
}
