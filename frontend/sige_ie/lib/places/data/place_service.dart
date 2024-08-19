import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/places/data/place_request_model.dart';
import 'package:sige_ie/places/data/place_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PlaceService {
  final Logger _logger = Logger('PlaceService');
  final String baseUrl = '$urlUniversal/api/places/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  // POST
  Future<int?> register(PlaceRequestModel placeRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(placeRequestModel.toJson()),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['id'];
      } else {
        _logger.info('Failed to register place: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  // GET ALL
  Future<List<PlaceResponseModel>> fetchAllPlaces() async {
    var url = Uri.parse(baseUrl);
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) => PlaceResponseModel.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      _logger.info('Error during fetchAllPlaces: $e');
      throw Exception('Failed to load places');
    }
  }

  // GET
  Future<PlaceResponseModel> fetchPlace(int placeId) async {
    var url = Uri.parse('$baseUrl$placeId/');

    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return PlaceResponseModel.fromJson(data);
      } else {
        throw Exception('Failed to load place with ID $placeId');
      }
    } catch (e) {
      _logger.info('Error during fetchPlace: $e');
      throw Exception('Failed to load place with ID $placeId');
    }
  }

  // PUT
  Future<bool> updatePlace(
      int placeId, PlaceRequestModel placeRequestModel) async {
    var url = Uri.parse('$baseUrl$placeId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(placeRequestModel.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      _logger.info('Error during updatePlace: $e');
      return false;
    }
  }

  // DELETE
  Future<bool> deletePlace(int placeId) async {
    var url = Uri.parse('$baseUrl$placeId/');

    try {
      var response = await client.delete(url);

      return response.statusCode == 204;
    } catch (e) {
      _logger.info('Error during deletePlace: $e');
      return false;
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
      try {
        // Fazer a solicitação HTTP para o backend
        final response = await client.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Salvar o arquivo localmente
          final directory = await getApplicationDocumentsDirectory();
          final filePath = '${directory.path}/$fileName';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          _logger.info('Arquivo baixado com sucesso');
        } else {
          throw Exception('Falha ao baixar o arquivo');
        }
      } catch (e) {
        _logger.info('Error during donwload file: $e');
      }
    }

}
