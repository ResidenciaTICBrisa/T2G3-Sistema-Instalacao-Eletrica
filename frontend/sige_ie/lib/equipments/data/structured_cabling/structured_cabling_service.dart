import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';
import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_response_model.dart';

class StructuredCablingEquipmentService {
  final Logger _logger = Logger('StructuredCablingEquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<StructuredCablingEquipmentResponseModel>>
      getStructuredCablingListByArea(int areaId) async {
    final url = '${baseUrl}structured-cabling/by-area/$areaId';
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _logger.info('API response data: $data');
        return data
            .map((item) =>
                StructuredCablingEquipmentResponseModel.fromJson(item))
            .toList();
      } else {
        _logger.severe(
            'Failed to load structured-cabling equipment with status code: ${response.statusCode}, response body: ${response.body}');
        throw Exception(
            'Failed to load structured-cabling equipment with status code: ${response.statusCode}');
      }
    } catch (e) {
      _logger.severe('Error during get structured-cabling equipment list: $e');
      throw Exception('Failed to load structured-cabling equipment. Error: $e');
    }
  }

  Future<void> deleteStructuredCabling(int structuredCablingId) async {
    var url = Uri.parse('${baseUrl}structured-cabling/$structuredCablingId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted structured cabling equipment with ID: $structuredCablingId');
      } else {
        _logger.info(
            'Failed to delete structured cabling equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete structured cabling equipment');
      }
    } catch (e) {
      _logger.info('Error during delete structured cabling equipment: $e');
      throw Exception('Failed to delete structured cabling equipment');
    }
  }
}
