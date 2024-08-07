import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_response_model.dart';
import 'package:sige_ie/shared/data/personal-equipment-category/personal_equipment_category_request_model.dart';
import 'package:sige_ie/main.dart';

class PersonalEquipmentCategoryService {
  final Logger _logger = Logger('PersonalEquipmentCategoryService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentCategoryResponseModel>>
      getAllPersonalEquipmentCategoryBySystem(int systemId) async {
    var url =
        Uri.parse('${baseUrl}personal-equipment-types/by-system/$systemId/');

    try {
      var response =
          await client.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<EquipmentCategoryResponseModel> equipmentList = responseData
            .map((item) => EquipmentCategoryResponseModel.fromJson(item))
            .toList();
        //_logger.info('Request successful, received ${equipmentList.length} items');
        return equipmentList;
      } else {
        _logger.info(
            'Failed to get personal equipment by system: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      _logger.info('Error during get all personal equipment by system: $e');
      return [];
    }
  }

  Future<int> createPersonalEquipmentCategory(
      PersonalEquipmentCategoryRequestModel
          personalEquipmentTypeRequestModel) async {
    var url = Uri.parse('${baseUrl}personal-equipment-types/');

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(personalEquipmentTypeRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        _logger.info(
            'Failed to register fire alarm equipment: ${response.statusCode}');
        return -1;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return -1;
    }
  }

  Future<bool> deletePersonalEquipmentCategory(int personalCategoryId) async {
    var url =
        Uri.parse('${baseUrl}personal-equipment-types/$personalCategoryId/');

    try {
      _logger.info('Sending DELETE request to $url');
      var response = await client
          .delete(url, headers: {'Content-Type': 'application/json'});

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      return response.statusCode == 204;
    } catch (e) {
      _logger.info('Error during delete equipment: $e');
      return false;
    }
  }
}
