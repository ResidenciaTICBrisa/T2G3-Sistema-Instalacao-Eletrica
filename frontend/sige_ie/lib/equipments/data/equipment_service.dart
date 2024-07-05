import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/atmospheric/atmospheric_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/distribution/distribution_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical_line/eletrical_line_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/refrigerations/refrigerations_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/fire_alarm/fire_alarm_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/iluminations/ilumination__equipment_request_model.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_equipment_request_model.dart';
import 'package:sige_ie/main.dart';

class EquipmentService {
  final Logger _logger = Logger('EquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/equipment-details/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );
  Future<Map<String, dynamic>> getFireAlarmById(int id) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/fire-alarms/$id/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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

  Future<Map<String, dynamic>> getEquipmentById(int id) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/equipments/$id/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        _logger.info(
            'Failed to load equipment with status code: ${response.statusCode}');
        throw Exception('Failed to load equipment');
      }
    } catch (e) {
      _logger.info('Error during get equipment: $e');
      throw Exception('Failed to load equipment');
    }
  }

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

  Future<int?> createIlumination(
      IluminationEquipmentRequestModel
          illuminationEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(illuminationEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register illumination equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createElectricalLoad(
      EletricalLoadEquipmentRequestModel
          electricalLoadEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(electricalLoadEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register electrical load equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createElectricalLine(
      EletricalLineEquipmentRequestModel
          electricalLineEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(electricalLineEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register electrical line equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createElectricalCircuit(
      EletricalCircuitEquipmentRequestModel
          electricalCircuitEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(electricalCircuitEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register electrical circuit equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createDistribution(
      DistributionEquipmentRequestModel
          distributionEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(distributionEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register distribution equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createRefrigerations(
      RefrigerationsEquipmentRequestModel
          RefrigerationsEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(RefrigerationsEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register refrigeration equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }

  Future<int?> createAtmospheric(
      AtmosphericEquipmentRequestModel atmosphericEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(atmosphericEquipmentRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register atmospheric equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return null;
    }
  }
}
