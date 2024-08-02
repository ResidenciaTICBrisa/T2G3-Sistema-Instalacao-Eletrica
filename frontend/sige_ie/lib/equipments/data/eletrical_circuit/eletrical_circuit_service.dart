import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_response_model.dart';
import 'package:sige_ie/main.dart';

class EletricalCircuitEquipmentService {
  final Logger _logger = Logger('EletricalCircuitEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EletricalCircuitEquipmentResponseByAreaModel>>
      getEletricalCircuitListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}electrical-circuits/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                EletricalCircuitEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load eletrical circuit equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load eletrical circuit equipment');
      }
    } catch (e) {
      _logger.info('Error during get eletrical circuit equipment list: $e');
      throw Exception('Failed to load eletrical circuit equipment');
    }
  }

  Future<void> deleteEletricalCircuit(int EletricalCircuitId) async {
    var url = Uri.parse('${baseUrl}electrical-circuits/$EletricalCircuitId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted eletrical circuit equipment with ID: $EletricalCircuitId');
      } else {
        _logger.info(
            'Failed to delete eletrical circuit equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete eletrical circuit equipment');
      }
    } catch (e) {
      _logger.info('Error during delete eletrical circuit equipment: $e');
      throw Exception('Failed to delete eletrical circuit equipment');
    }
  }

  Future<EletricalCircuitResponseModel> getEletricalCircuitById(
      int EletricalCircuitId) async {
    var url = Uri.parse('${baseUrl}electrical-circuits/$EletricalCircuitId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return EletricalCircuitResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load eletrical circuit with status code: ${response.statusCode}');
        throw Exception('Failed to load eletrical circuit');
      }
    } catch (e) {
      _logger.info('Error during get eletrical circuit: $e');
      throw Exception('Failed to load eletrical circuit');
    }
  }

  Future<bool> updateEletricalCircuit(int EletricalCircuitId,
      EletricalCircuitRequestModel EletricalCircuitIdRequestModel) async {
    var url = Uri.parse('${baseUrl}electrical-circuits/$EletricalCircuitId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(EletricalCircuitIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated eletrical circuit equipment with ID: $EletricalCircuitId');
        return true;
      } else {
        _logger.info(
            'Failed to update eletrical circuit equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update eletrical circuit equipment: $e');
      return false;
    }
  }
}
