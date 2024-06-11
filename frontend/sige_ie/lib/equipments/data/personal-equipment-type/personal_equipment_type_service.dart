import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_response_model.dart';
import 'package:sige_ie/equipments/data/personal-equipment-type/personal_equipment_type_request_model.dart';
import 'package:sige_ie/main.dart';

class PersonalEquipmentTypeService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentTypeResponseModel>> getAllPersonalEquipmentBySystem(
      int systemId) async {
    var url =
        Uri.parse('${baseUrl}personal-equipment-types/by-system/$systemId/');

    try {
      var response =
          await client.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<EquipmentTypeResponseModel> equipmentList = responseData
            .map((item) => EquipmentTypeResponseModel.fromJson(item))
            .toList();
        //print('Request successful, received ${equipmentList.length} items');
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

  Future<int> createPersonalEquipmentType(
      PersonalEquipmentTypeRequestModel
          personalEquipmentTypeRequestModel) async {
    var url = Uri.parse('${baseUrl}personal-equipment-types/');

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(personalEquipmentTypeRequestModel.toJson()),
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
        return -1;
      }
    } catch (e) {
      print('Error during register: $e');
      return -1;
    }
  }

  Future<bool> deletePersonalEquipmentType(int id) async {
    var url = Uri.parse('${baseUrl}personal-equipment-types/$id/');

    try {
      print('Sending DELETE request to $url');
      var response = await client
          .delete(url, headers: {'Content-Type': 'application/json'});

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == 204;
    } catch (e) {
      print('Error during delete equipment: $e');
      return false;
    }
  }
}
