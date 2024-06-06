import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/cooling/cooling_request_model.dart';
import 'package:sige_ie/main.dart';

class CoolingEquipmentService {
  final String baseUrl = 'http://10.0.2.2:8000/api/equipment-details/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<int?> register(
      CoolingEquipmentRequestModel coolingEquipmentRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      print('Sending POST request to $url');
      print(
          'Request body: ${jsonEncode(coolingEquipmentRequestModel.toJson())}');

      var response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(coolingEquipmentRequestModel.toJson()),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Request successful, received ID: ${responseData['id']}');
        return responseData['id'];
      } else {
        print('Failed to register cooling equipment: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during register: $e');
      return null;
    }
  }
}
