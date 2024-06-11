import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_response_model.dart';
import 'package:sige_ie/main.dart';

class FireAlarmEquipmentService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );
  Future<List<EquipmentTypeResponseModel>> getAllEquipment(
      int systemId,
      List<EquipmentTypeResponseModel> equipmentTypeList,
      List<EquipmentTypeResponseModel> personalEquipmentList) async {
    List<EquipmentTypeResponseModel> combinedList = [
      ...equipmentTypeList,
      ...personalEquipmentList,
    ];
    try {
      print('Combined list length: ${combinedList.length}');
      return combinedList;
    } catch (e) {
      print('Error during get all equipment: $e');
      return [];
    }
  }

  Future<List<String>> getEquipmentListByArea(int areaId) async {
    final url = '${baseUrl}fire-alarms/by-area/$areaId';
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item['name'] as String).toList();
      } else {
        throw Exception('Failed to load equipment');
      }
    } catch (e) {
      print('Error during get equipment list: $e');
      return [];
    }
  }
}
