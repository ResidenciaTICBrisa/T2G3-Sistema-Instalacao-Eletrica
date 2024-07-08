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

    print(
        'Sending request to: $url with body: ${jsonEncode(equipmentPhotoRequestModel.toJson())}');

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
        print('Request successful, received ID: ${responseData['id']}');
        return true;
      } else {
        _logger
            .info('Failed to register equipment photo: ${response.statusCode}');
        print('Failed to register equipment photo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      print('Error during register: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPhotosByEquipmentId(
      int fireAlarmId) async {
    try {
      // Fetch the equipment ID from the fire alarm endpoint
      var fireAlarmUrl =
          Uri.parse('http://10.0.2.2:8000/api/fire-alarms/$fireAlarmId/');
      print('Fetching fire alarm details from: $fireAlarmUrl');
      var fireAlarmResponse = await client.get(fireAlarmUrl);

      if (fireAlarmResponse.statusCode != 200) {
        _logger.warning(
            'Failed to fetch fire alarm details: ${fireAlarmResponse.statusCode}');
        print(
            'Failed to fetch fire alarm details: ${fireAlarmResponse.statusCode}');
        return [];
      }

      Map<String, dynamic> fireAlarmData = jsonDecode(fireAlarmResponse.body);
      print('Fire alarm data: $fireAlarmData');
      int equipmentId = fireAlarmData['equipment'];

      // Fetch the photos using the equipment ID
      var photosUrl = Uri.parse(
          'http://10.0.2.2:8000/api/equipment-photos/by-equipment/$equipmentId/');
      print('Fetching photos from: $photosUrl');
      var photosResponse = await client.get(photosUrl);

      if (photosResponse.statusCode != 200) {
        _logger.warning(
            'Failed to fetch equipment photos: ${photosResponse.statusCode}');
        print('Failed to fetch equipment photos: ${photosResponse.statusCode}');
        return [];
      }

      List<dynamic> photosData = jsonDecode(photosResponse.body);
      print('Photos data: $photosData');

      _logger.info('Fetched equipment photos successfully');
      print('Fetched equipment photos successfully');

      return List<Map<String, dynamic>>.from(photosData);
    } catch (e) {
      _logger.severe('Error fetching photos by equipment ID: $e');
      print('Error fetching photos by equipment ID: $e');
      return [];
    }
  }
}
