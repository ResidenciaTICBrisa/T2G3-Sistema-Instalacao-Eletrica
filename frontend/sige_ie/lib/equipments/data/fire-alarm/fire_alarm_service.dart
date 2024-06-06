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

  Future<List<EquipmentTypeResponseModel>> getAllEquipment(int systemId, equipmentTypeList, personalEquipmentList) async {
  
      List<EquipmentTypeResponseModel> combinedList = [
        ...equipmentTypeList,
        ...personalEquipmentList,
      ];

      print('Combined list length: ${combinedList.length}');
      return combinedList;
    } catch (e) {
      print('Error during get all equipment: $e');
      return [];
    }
  }

  Future<bool> registerEquipmentDetail(
      Map<String, dynamic> requestPayload) async {
    var url = Uri.parse('${baseUrl}equipment-details/');

    try {
      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to register equipment detail: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during register equipment detail: $e');
      return false;
    }
  }
}
