import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_request_model.dart';

class EquipmentPhotoService {
  final Logger _logger = Logger('EquipmentPhotoService');
  final String baseUrl = 'http://10.0.2.2:8000/api/equipment-photos/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<bool> createPhoto(
      EquipmentPhotoRequestModel equipmentPhotoRequestModel) async {
    var url = Uri.parse(baseUrl);

    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(equipmentPhotoRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        _logger.info('Request successful, received ID: ${responseData['id']}');
        return true;
      } else {
        _logger.info('Failed to register equipment photo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return false;
    }
  }
}
