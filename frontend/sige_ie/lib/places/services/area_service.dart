import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/services/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/places/models/area_request_model.dart';

class AreaService {
  Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  final String baseUrl = 'http://10.0.2.2:8000/api/areas/';

  // POST
  Future<bool> createRoom(RoomRequestModel roomRequestModel) async {
    var url = Uri.parse(baseUrl);

    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(roomRequestModel.toJson()),
    );

    return response.statusCode == 201;
  }

  // Ainda não testado
  // GET
  Future<RoomRequestModel> fetchRoom(int roomId) async {
    var url = Uri.parse('$baseUrl$roomId/');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return RoomRequestModel.fromJson(data);
    } else {
      throw Exception('Failed to load room with ID $roomId');
    }
  }

  // PUT
  Future<bool> updateRoom(int roomId, RoomRequestModel roomRequestModel) async {
    var url = Uri.parse('$baseUrl$roomId/');

    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(roomRequestModel.toJson()),
    );

    return response.statusCode == 200;
  }

  // DELETE
  Future<bool> deleteRoom(int roomId) async {
    var url = Uri.parse('$baseUrl$roomId/');

    var response = await client.delete(url);

    return response.statusCode == 204;
  }
}
