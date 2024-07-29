import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/areas/data/area_response_model.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/areas/data/area_request_model.dart';

class AreaService {
  final Logger _logger = Logger('AreaService');
  Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  final String baseUrl = '$urlUniversal/api/areas/';

  // POST
// POST
  Future<AreaResponseModel> createArea(
      AreaRequestModel areaRequestModel) async {
    var url = Uri.parse(baseUrl);
    print('URL: $url'); // Log da URL
    print(
        'Request Body: ${jsonEncode(areaRequestModel.toJson())}'); // Log do corpo da requisição

    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(areaRequestModel.toJson()),
    );

    print(
        'Response Status Code: ${response.statusCode}'); // Log do status da resposta
    print('Response Body: ${response.body}'); // Log do corpo da resposta

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print('Response Data: $data'); // Log dos dados da resposta
      return AreaResponseModel.fromJson(data);
    } else {
      print(
          'Failed to create area. Status Code: ${response.statusCode}'); // Log do erro com status code
      throw Exception('Failed to create area');
    }
  }

  // Fetch all areas for a specific place
  Future<List<AreaResponseModel>> fetchAreasByPlaceId(int placeId) async {
    var url = Uri.parse('$urlUniversal/api/places/$placeId/areas/');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      return dataList.map((data) => AreaResponseModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load areas for place $placeId');
    }
  }

  // GET
  Future<AreaResponseModel> fetchArea(int areaId) async {
    var url = Uri.parse('$baseUrl$areaId/');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return AreaResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load area with ID $areaId');
    }
  }

  // PUT
  Future<bool> updateArea(int areaId, AreaRequestModel areaRequestModel) async {
    var url = Uri.parse('$baseUrl$areaId/');

    _logger.info('Sending PUT request to $url');
    _logger.info('Request body: ${jsonEncode(areaRequestModel.toJson())}');

    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(areaRequestModel.toJson()),
    );

    _logger.info('Response status: ${response.statusCode}');
    _logger.info('Response body: ${response.body}');

    return response.statusCode == 200;
  }

  // DELETE
  Future<bool> deleteArea(int areaId) async {
    var url = Uri.parse('$baseUrl$areaId/');

    var response = await client.delete(url);

    return response.statusCode == 204;
  }
}
