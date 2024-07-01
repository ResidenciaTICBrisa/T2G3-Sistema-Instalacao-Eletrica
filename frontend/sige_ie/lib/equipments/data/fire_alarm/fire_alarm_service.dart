import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/fire_alarm/fire_alarm_response_model.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_response_model.dart';
import 'package:sige_ie/main.dart';

class FireAlarmEquipmentService {
  final Logger _logger = Logger('FireAlarmEquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentCategoryResponseModel>> getAllEquipment(
      int systemId,
      List<EquipmentCategoryResponseModel> genericEquipmentCategoryList,
      List<EquipmentCategoryResponseModel>
          personalEquipmentCategoryList) async {
    List<EquipmentCategoryResponseModel> combinedList = [
      ...genericEquipmentCategoryList,
      ...personalEquipmentCategoryList,
    ];
    try {
      _logger.info('Combined list length: ${combinedList.length}');
      return combinedList;
    } catch (e) {
      _logger.info('Error during get all equipment: $e');
      return [];
    }
  }

  Future<List<FireAlarmEquipmentResponseModel>> getFireAlarmListByArea(
      int areaId) async {
    var url = Uri.parse('${baseUrl}fire-alarms/by-area/$areaId/');
    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) => FireAlarmEquipmentResponseModel.fromJson(data))
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
}
