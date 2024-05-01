import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/places/data/place_request_model.dart';

class PlaceService {
  Future<bool> register(PlaceRequestModel placeRequestModel) async {
    var client = InterceptedClient.build(
      interceptors: [AuthInterceptor(cookieJar)],
    );
    var url = Uri.parse('http://10.0.2.2:8000/api/places/');

    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(placeRequestModel.toJson()),
    );
    return response.statusCode == 201;
  }
}
