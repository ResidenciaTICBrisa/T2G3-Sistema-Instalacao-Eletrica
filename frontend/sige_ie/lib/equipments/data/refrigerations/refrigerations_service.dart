import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/refrigerations/refrigerations_request_model.dart';
import 'package:sige_ie/equipments/data/refrigerations/refrigerations_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/refrigerations/refrigerations_response_model.dart';
import 'package:sige_ie/main.dart';

class RefrigerationsEquipmentService {
  final Logger _logger = Logger('RefrigerationsEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<RefrigerationsEquipmentResponseByAreaModel>>
      getRefrigerationsListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}refrigerations/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                RefrigerationsEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load refrigerations equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load refrigerations equipment');
      }
    } catch (e) {
      _logger.info('Error during get refrigerations equipment list: $e');
      throw Exception('Failed to load refrigerations equipment');
    }
  }

  Future<void> deleteRefrigerations(int RefrigerationsId) async {
    var url = Uri.parse('${baseUrl}refrigerations/$RefrigerationsId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted refrigerations equipment with ID: $RefrigerationsId');
      } else {
        _logger.info(
            'Failed to delete refrigerations equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete refrigerations equipment');
      }
    } catch (e) {
      _logger.info('Error during delete refrigerations equipment: $e');
      throw Exception('Failed to delete refrigerations equipment');
    }
  }

  Future<RefrigerationsResponseModel> getRefrigerationsById(
      int RefrigerationsId) async {
    var url = Uri.parse('${baseUrl}refrigerations/$RefrigerationsId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return RefrigerationsResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load refrigerations with status code: ${response.statusCode}');
        throw Exception('Failed to load refrigerations');
      }
    } catch (e) {
      _logger.info('Error during get refrigerations: $e');
      throw Exception('Failed to load refrigerations');
    }
  }

  Future<bool> updateRefrigerations(int RefrigerationsId,
      RefrigerationsRequestModel RefrigerationsIdRequestModel) async {
    var url = Uri.parse('${baseUrl}refrigerations/$RefrigerationsId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(RefrigerationsIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated refrigerations equipment with ID: $RefrigerationsId');
        return true;
      } else {
        _logger.info(
            'Failed to update refrigerations equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update refrigerations equipment: $e');
      return false;
    }
  }
}
