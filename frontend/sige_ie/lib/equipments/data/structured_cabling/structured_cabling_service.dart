import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_request_model.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_response_model.dart';
import 'package:sige_ie/main.dart';

class StructuredCablingEquipmentService {
  final Logger _logger = Logger('StructuredCablingEquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<StructuredCablingEquipmentResponseByAreaModel>>
      getStructuredCablingListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}fire-alarms/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                StructuredCablingEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load fire alarm equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load fire alarm equipment');
      }
    } catch (e) {
      _logger.info('Error during get fire alarm equipment list: $e');
      throw Exception('Failed to load fire alarm equipment');
    }
  }

  Future<void> deleteStructuredCabling(int structuredCablingId) async {
    var url = Uri.parse('${baseUrl}fire-alarms/$structuredCablingId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted fire alarm equipment with ID: $structuredCablingId');
      } else {
        _logger.info(
            'Failed to delete fire alarm equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete fire alarm equipment');
      }
    } catch (e) {
      _logger.info('Error during delete fire alarm equipment: $e');
      throw Exception('Failed to delete fire alarm equipment');
    }
  }

  Future<StructuredCablingResponseModel> getStructuredCablingById(
      int structuredCablingId) async {
    var url = Uri.parse('${baseUrl}fire-alarms/$structuredCablingId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return StructuredCablingResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load fire alarm with status code: ${response.statusCode}');
        throw Exception('Failed to load fire alarm');
      }
    } catch (e) {
      _logger.info('Error during get fire alarm: $e');
      throw Exception('Failed to load fire alarm');
    }
  }

  Future<bool> updateStructuredCabling(int structuredCablingId,
      StructuredCablingRequestModel structuredCablingIdRequestModel) async {
    var url = Uri.parse('${baseUrl}fire-alarms/$structuredCablingId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(structuredCablingIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated fire alarm equipment with ID: $structuredCablingId');
        return true;
      } else {
        _logger.info(
            'Failed to update fire alarm equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update fire alarm equipment: $e');
      return false;
    }
  }
}
