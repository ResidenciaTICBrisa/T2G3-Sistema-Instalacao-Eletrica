import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/areas/data/area_response_model.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/areas/data/area_request_model.dart';

class AreaService {
  Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  final String baseUrl = 'http://10.0.2.2:8000/api/areas/';

  // POST
  Future<bool> createArea(AreaRequestModel areaRequestModel) async {
    var url = Uri.parse(baseUrl);

    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(areaRequestModel.toJson()),
    );

    return response.statusCode == 201;
  }

  // Fetch all areas for a specific place
  Future<List<AreaResponseModel>> fetchAreasByPlaceId(int placeId) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/places/$placeId/areas/');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      return dataList.map((data) => AreaResponseModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load areas for place $placeId');
    }
  }

  // Ainda não testado
  // GET
  Future<AreaRequestModel> fetchArea(int areaId) async {
    var url = Uri.parse('$baseUrl$areaId/');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return AreaRequestModel.fromJson(data);
    } else {
      throw Exception('Failed to load area with ID $areaId');
    }
  }

  // PUT
  Future<bool> updateArea(int areaId, AreaRequestModel areaRequestModel) async {
    var url = Uri.parse('$baseUrl$areaId/');

    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(areaRequestModel.toJson()),
    );

    return response.statusCode == 200;
  }

  // DELETE
  Future<bool> deleteArea(int areaId) async {
    var url = Uri.parse('$baseUrl$areaId/');

    var response = await client.delete(url);

    return response.statusCode == 204;
  }
}
