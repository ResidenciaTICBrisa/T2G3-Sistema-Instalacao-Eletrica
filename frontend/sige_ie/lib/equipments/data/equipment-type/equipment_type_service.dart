import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_response_model.dart';
import 'package:sige_ie/main.dart';

class EquipmentTypeService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentTypeResponseModel>> getAllEquipmentTypeBySystem(
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
        List<EquipmentTypeResponseModel> equipmentList = responseData
            .map((item) => EquipmentTypeResponseModel.fromJson(item))
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
}
