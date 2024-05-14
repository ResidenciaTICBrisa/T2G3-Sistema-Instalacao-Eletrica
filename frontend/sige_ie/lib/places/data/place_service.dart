import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/places/data/place_request_model.dart';
import 'package:sige_ie/places/data/place_response_model.dart';

class PlaceService {
  final String baseUrl = 'http://10.0.2.2:8000/api/places/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  // POST
  Future<int?> register(PlaceRequestModel placeRequestModel) async {
    var url = Uri.parse(baseUrl);

    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(placeRequestModel.toJson()),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['id'];
    } else {
      return null;
    }
  }

  // GET ALL
  Future<List<PlaceResponseModel>> fetchAllPlaces() async {
    var url = Uri.parse(baseUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      return dataList.map((data) => PlaceResponseModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  // GET
  Future<PlaceResponseModel> fetchPlace(int placeId) async {
    var url = Uri.parse('$baseUrl$placeId/');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PlaceResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load place with ID $placeId');
    }
  }

  // PUT
  Future<bool> updatePlace(
      int placeId, PlaceRequestModel placeRequestModel) async {
    var url = Uri.parse('$baseUrl$placeId/');

    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(placeRequestModel.toJson()),
    );

    return response.statusCode == 200;
  }

  // DELETE
  Future<bool> deletePlace(int placeId) async {
    var url = Uri.parse('$baseUrl$placeId/');

    var response = await client.delete(url);

    return response.statusCode == 204;
  }
}
