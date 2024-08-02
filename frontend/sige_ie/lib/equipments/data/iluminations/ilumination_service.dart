import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/iluminations/ilumination_request_model.dart';
import 'package:sige_ie/equipments/data/iluminations/ilumination_response.dart';
import 'package:sige_ie/equipments/data/iluminations/ilumination_response_by_area_model.dart';
import 'package:sige_ie/main.dart';

class IluminationEquipmentService {
  final Logger _logger = Logger('IluminationEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<IluminationEquipmentResponseByAreaModel>>
      getIluminationListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}iluminations/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                IluminationEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load ilumination equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load ilumination equipment');
      }
    } catch (e) {
      _logger.info('Error during get ilumination equipment list: $e');
      throw Exception('Failed to load ilumination equipment');
    }
  }

  Future<void> deleteIlumination(int IluminationId) async {
    var url = Uri.parse('${baseUrl}iluminations/$IluminationId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted ilumination equipment with ID: $IluminationId');
      } else {
        _logger.info(
            'Failed to delete ilumination equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete ilumination equipment');
      }
    } catch (e) {
      _logger.info('Error during delete ilumination equipment: $e');
      throw Exception('Failed to delete ilumination equipment');
    }
  }

  Future<IluminationResponseModel> getIluminationById(int IluminationId) async {
    var url = Uri.parse('${baseUrl}iluminations/$IluminationId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return IluminationResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load ilumination with status code: ${response.statusCode}');
        throw Exception('Failed to load ilumination');
      }
    } catch (e) {
      _logger.info('Error during get ilumination: $e');
      throw Exception('Failed to load ilumination');
    }
  }

  Future<bool> updateIlumination(int IluminationId,
      IluminationRequestModel IluminationIdRequestModel) async {
    var url = Uri.parse('${baseUrl}iluminations/$IluminationId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(IluminationIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated ilumination equipment with ID: $IluminationId');
        return true;
      } else {
        _logger.info(
            'Failed to update ilumination equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update ilumination equipment: $e');
      return false;
    }
  }
}
