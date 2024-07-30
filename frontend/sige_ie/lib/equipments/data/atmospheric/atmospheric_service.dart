import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/atmospheric/atmospheric_request_model.dart';
import 'package:sige_ie/equipments/data/atmospheric/atmospheric_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/atmospheric/atmospheric_response_model.dart';
import 'package:sige_ie/main.dart';

class AtmosphericEquipmentService {
  final Logger _logger = Logger('AtmosphericEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<AtmosphericEquipmentResponseByAreaModel>>
      getAtmosphericListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}structured-cabling/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                AtmosphericEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load structured cabling equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load structured cabling equipment');
      }
    } catch (e) {
      _logger.info('Error during get structured cabling equipment list: $e');
      throw Exception('Failed to load structured cabling equipment');
    }
  }

  Future<void> deleteAtmospheric(int AtmosphericId) async {
    var url = Uri.parse('${baseUrl}structured-cabling/$AtmosphericId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted structured cabling equipment with ID: $AtmosphericId');
      } else {
        _logger.info(
            'Failed to delete structured cabling equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete structured cabling equipment');
      }
    } catch (e) {
      _logger.info('Error during delete structured cabling equipment: $e');
      throw Exception('Failed to delete structured cabling equipment');
    }
  }

  Future<AtmosphericResponseModel> getAtmosphericById(int AtmosphericId) async {
    var url = Uri.parse('${baseUrl}structured-cabling/$AtmosphericId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return AtmosphericResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load structured cabling with status code: ${response.statusCode}');
        throw Exception('Failed to load structured cabling');
      }
    } catch (e) {
      _logger.info('Error during get structured cabling: $e');
      throw Exception('Failed to load structured cabling');
    }
  }

  Future<bool> updateAtmospheric(int AtmosphericId,
      AtmosphericRequestModel AtmosphericIdRequestModel) async {
    var url = Uri.parse('${baseUrl}structured-cabling/$AtmosphericId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(AtmosphericIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated structured cabling equipment with ID: $AtmosphericId');
        return true;
      } else {
        _logger.info(
            'Failed to update structured cabling equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update structured cabling equipment: $e');
      return false;
    }
  }
}
