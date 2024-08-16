import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/users/data/password_request_model.dart';
import 'package:sige_ie/users/data/user_request_model.dart';
import 'package:sige_ie/users/data/user_response_model.dart';
import 'package:sige_ie/users/data/username_request_model.dart';

class UserService {
  final Logger _logger = Logger('UserService');

  Future<bool> register(UserRequestModel userRequestModel) async {
    var url = Uri.parse('$urlUniversal/api/users/');

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userRequestModel.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<bool> update(String id, String firstName, String email) async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    var url = Uri.parse('$urlUniversal/api/users/$id/');
    try {
      var response = await client.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'first_name': firstName,
            'email': email,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(PasswordRequestModel passwordRequestModel) async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    var url = Uri.parse('$urlUniversal/api/change_password/');
    try {
      var response = await client.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(passwordRequestModel.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _logger.info('Erro ao atualizar password: $e');
      return false;
    }
  }

  Future<bool> changeUsername(UsernameRequestModel usernameRequestModel) async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    var url = Uri.parse('$urlUniversal/api/change_username/');
    try {
      var response = await client.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(usernameRequestModel.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _logger.info('Erro ao atualizar username: $e');
      return false;
    }
  }

  Future<bool> delete(String id) async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    var url = Uri.parse('$urlUniversal/api/users/$id/');
    try {
      var response = await client
          .delete(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<UserResponseModel> fetchProfileData() async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );

    try {
      final response =
          await client.get(Uri.parse('$urlUniversal/api/userauth'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return UserResponseModel.fromJson(data);
      } else {
        throw Exception('Falha ao carregar dados do perfil');
      }
    } on http.ClientException catch (e) {
      _logger.info('Erro ao carregar dados do perfil (ClientException): $e');
      throw Exception(
          'Erro na conexão com o servidor. Por favor, tente novamente mais tarde.');
    } on SocketException catch (e) {
      _logger.info('Erro ao carregar dados do perfil (SocketException): $e');
      throw Exception('Erro de rede. Verifique sua conexão com a internet.');
    } catch (e) {
      _logger.info('Erro ao carregar dados do perfil: $e');
      throw Exception(
          'Ocorreu um erro inesperado. Por favor, tente novamente.');
    }
  }
}
