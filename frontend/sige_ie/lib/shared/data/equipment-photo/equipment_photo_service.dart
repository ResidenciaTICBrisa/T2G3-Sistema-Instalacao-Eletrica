import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_request_model.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_response_model.dart';

class EquipmentPhotoService {
  final Logger _logger = Logger('EquipmentPhotoService');
  final String baseUrl = '$urlUniversal/api/equipment-photos/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<bool> createPhoto(
      EquipmentPhotoRequestModel equipmentPhotoRequestModel) async {
    var url = Uri.parse(baseUrl);

    _logger.info(
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
        return true;
      } else {
        _logger
            .info('Failed to register equipment photo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during register: $e');
      return false;
    }
  }

  Future<List<EquipmentPhotoResponseModel>> getPhotosByEquipmentId(
      int equipmentId) async {
    try {
      var url = Uri.parse(
          '$urlUniversal/api/equipment-photos/by-equipment/$equipmentId/');
      _logger.info('Fetching photos from: $url');
      var photosResponse = await client.get(url);

      if (photosResponse.statusCode != 200) {
        _logger.warning(
            'Failed to fetch equipment photos: ${photosResponse.statusCode}');
        return [];
      }

      List<dynamic> photosData = jsonDecode(photosResponse.body);

      _logger.info('Photos data: $photosData');

      List<EquipmentPhotoResponseModel> photoModels =
          photosData.map((photoData) {
        return EquipmentPhotoResponseModel.fromJson(photoData);
      }).toList();

      _logger.info('Fetched equipment photos successfully');

      return photoModels;
    } catch (e) {
      _logger.severe('Error fetching and converting photos: $e');
      return [];
    }
  }

  Future<bool> deletePhoto(int photoId) async {
    var url = Uri.parse('$baseUrl$photoId/');

    _logger.info('Sending DELETE request to: $url');

    try {
      var response = await client.delete(url, headers: {
        'Content-Type': 'application/json',
      });

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 204 || response.statusCode == 200) {
        _logger.info('Photo deleted successfully');
        return true;
      } else {
        _logger.info('Failed to delete photo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.severe('Error during delete: $e');
      return false;
    }
  }

  Future<bool> updatePhoto(int photoId,
      EquipmentPhotoRequestModel equipmentPhotoRequestModel) async {
    var url = Uri.parse('$baseUrl$photoId/');

    _logger.info(
        'Sending PUT request to: $url with body: ${jsonEncode(equipmentPhotoRequestModel.toJson())}');

    try {
      var response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(equipmentPhotoRequestModel.toJson()),
      );

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 200) {
        _logger.info('Photo updated successfully');
        return true;
      } else {
        _logger.info('Failed to update photo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.severe('Error during update: $e');
      return false;
    }
  }
}
