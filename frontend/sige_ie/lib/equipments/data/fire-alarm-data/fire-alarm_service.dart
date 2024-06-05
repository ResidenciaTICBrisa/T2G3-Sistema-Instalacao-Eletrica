import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/fire-alarm-data/fire-alarm_request_model.dart';
import 'package:sige_ie/equipments/data/fire-alarm-data/fire-alarm_response_model.dart'; // Import the response model
import 'package:sige_ie/main.dart';

class FireAlarmEquipmentService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<int?> register(
      FireAlarmEquipmentRequestModel fireAlarmEquipmentRequestModel) async {
    var url = Uri.parse('${baseUrl}personal-equipment-types/');

    try {
      print('Sending POST request to $url');
      print(
          'Request body: ${jsonEncode(fireAlarmEquipmentRequestModel.toJson())}');

      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(fireAlarmEquipmentRequestModel.toJson()),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        print(
            'Failed to register fire alarm equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during register: $e');
      return null;
    }
  }

  Future<List<FireAlarmEquipmentResponseModel>> getAllPersonalEquipmentBySystem(
      int systemId) async {
    var url =
        Uri.parse('${baseUrl}personal-equipment-types/by-system/$systemId/');

    try {
      print('Sending GET request to $url');
      var response =
          await client.get(url, headers: {'Content-Type': 'application/json'});

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<FireAlarmEquipmentResponseModel> equipmentList = responseData
            .map((item) => FireAlarmEquipmentResponseModel.fromJson(item))
            .toList();
        print('Request successful, received ${equipmentList.length} items');
        return equipmentList;
      } else {
        print(
            'Failed to get personal equipment by system: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error during get all personal equipment by system: $e');
      return [];
    }
  }

  Future<List<FireAlarmEquipmentResponseModel>> getAllEquipmentBySystem(
      int systemId) async {
    var url = Uri.parse('${baseUrl}equipment-types/by-system/$systemId/');

    try {
      print('Sending GET request to $url');
      var response =
          await client.get(url, headers: {'Content-Type': 'application/json'});

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<FireAlarmEquipmentResponseModel> equipmentList = responseData
            .map((item) => FireAlarmEquipmentResponseModel.fromJson(item))
            .toList();
        print('Request successful, received ${equipmentList.length} items');
        return equipmentList;
      } else {
        print('Failed to get equipment by system: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error during get all equipment by system: $e');
      return [];
    }
  }

  Future<List<FireAlarmEquipmentResponseModel>> getAllEquipment(
      int systemId) async {
    try {
      List<FireAlarmEquipmentResponseModel> equipmentList =
          await getAllEquipmentBySystem(systemId);
      List<FireAlarmEquipmentResponseModel> personalEquipmentList =
          await getAllPersonalEquipmentBySystem(systemId);

      List<FireAlarmEquipmentResponseModel> combinedList = [
        ...equipmentList,
        ...personalEquipmentList,
      ];

      print('Combined list length: ${combinedList.length}');
      return combinedList;
    } catch (e) {
      print('Error during get all equipment: $e');
      return [];
    }
  }
}
