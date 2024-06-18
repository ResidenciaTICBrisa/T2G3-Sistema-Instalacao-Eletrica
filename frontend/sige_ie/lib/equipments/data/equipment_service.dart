import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/fire_alarm/fire_alarm_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_equipment_request_model.dart'; // Importe o modelo necessário
import 'package:sige_ie/main.dart';

class EquipmentService {
  final Logger _logger = Logger('EquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/equipment-details/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<int?> createFireAlarm(
      FireAlarmEquipmentRequestModel fireAlarmEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(fireAlarmEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register fire alarm equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createStructuredCabling(
      StructuredCablingEquipmentRequestModel
          structuredCablingEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(structuredCablingEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register structured cabling equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }
}
