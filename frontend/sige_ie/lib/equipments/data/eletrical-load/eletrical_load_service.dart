import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_request_model.dart.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_response_model.dart';
import 'package:sige_ie/main.dart';

class EletricalLoadEquipmentService {
  final Logger _logger = Logger('EletricalLoadEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EletricalLoadEquipmentResponseByAreaModel>>
      getEletricalLoadListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}electrical-loads/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                EletricalLoadEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load electrical loads equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load electrical loads equipment');
      }
    } catch (e) {
      _logger.info('Error during get electrical loads equipment list: $e');
      throw Exception('Failed to load electrical loads equipment');
    }
  }

  Future<void> deleteEletricalLoad(int EletricalLoadId) async {
    var url = Uri.parse('${baseUrl}electrical-loads/$EletricalLoadId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted electrical loads equipment with ID: $EletricalLoadId');
      } else {
        _logger.info(
            'Failed to delete electrical loads equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete electrical loads equipment');
      }
    } catch (e) {
      _logger.info('Error during delete electrical loads equipment: $e');
      throw Exception('Failed to delete electrical loads equipment');
    }
  }

  Future<EletricalLoadResponseModel> getEletricalLoadById(
      int EletricalLoadId) async {
    var url = Uri.parse('${baseUrl}electrical-loads/$EletricalLoadId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return EletricalLoadResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load electrical loads with status code: ${response.statusCode}');
        throw Exception('Failed to load electrical loads');
      }
    } catch (e) {
      _logger.info('Error during get electrical loads: $e');
      throw Exception('Failed to load electrical loads');
    }
  }

  Future<bool> updateEletricalLoad(int EletricalLoadId,
      EletricalLoadRequestModel EletricalLoadIdRequestModel) async {
    var url = Uri.parse('${baseUrl}electrical-loads/$EletricalLoadId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(EletricalLoadIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated electrical loads equipment with ID: $EletricalLoadId');
        return true;
      } else {
        _logger.info(
            'Failed to update electrical loads equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update electrical loads equipment: $e');
      return false;
    }
  }
}
