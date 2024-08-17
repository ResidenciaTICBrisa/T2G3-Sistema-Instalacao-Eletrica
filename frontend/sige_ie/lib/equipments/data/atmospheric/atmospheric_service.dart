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
    var url = Uri.parse('${baseUrl}atmospheric-discharges/by-area/$areaId/');
    try {
      var response = await client.get(url);
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                AtmosphericEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load atmospheric discharges equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load atmospheric discharges equipment');
      }
    } catch (e) {
      _logger
          .info('Error during get atmospheric discharges equipment list: $e');
      throw Exception('Failed to load atmospheric discharges equipment');
    }
  }

  Future<void> deleteAtmospheric(int AtmosphericId) async {
    var url = Uri.parse('${baseUrl}atmospheric-discharges/$AtmosphericId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted atmospheric discharges equipment with ID: $AtmosphericId');
      } else {
        _logger.info(
            'Failed to delete atmospheric discharges equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete atmospheric discharges equipment');
      }
    } catch (e) {
      _logger.info('Error during delete atmospheric discharges equipment: $e');
      throw Exception('Failed to delete atmospheric discharges equipment');
    }
  }

  Future<AtmosphericResponseModel> getAtmosphericById(int AtmosphericId) async {
    var url = Uri.parse('${baseUrl}atmospheric-discharges/$AtmosphericId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return AtmosphericResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load atmospheric discharges with status code: ${response.statusCode}');
        throw Exception('Failed to load atmospheric discharges');
      }
    } catch (e) {
      _logger.info('Error during get atmospheric discharges: $e');
      throw Exception('Failed to load atmospheric discharges');
    }
  }

  Future<bool> updateAtmospheric(int AtmosphericId,
      AtmosphericRequestModel AtmosphericIdRequestModel) async {
    var url = Uri.parse('${baseUrl}atmospheric-discharges/$AtmosphericId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(AtmosphericIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated atmospheric discharges equipment with ID: $AtmosphericId');
        return true;
      } else {
        _logger.info(
            'Failed to update atmospheric discharges equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update atmospheric discharges equipment: $e');
      return false;
    }
  }
}
