import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_response_model.dart';
import 'package:sige_ie/main.dart';

class GenericEquipmentCategoryService {
  final Logger _logger = Logger('GenericEquipmentCategoryService');
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentCategoryResponseModel>>
      getAllGenericEquipmentCategoryBySystem(int systemId) async {
    var url = Uri.parse('${baseUrl}equipment-types/by-system/$systemId/');

    try {
      _logger.info('Sending GET request to $url');
      var response =
          await client.get(url, headers: {'Content-Type': 'application/json'});

      _logger.info('Response status code: ${response.statusCode}');
      _logger.info('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<EquipmentCategoryResponseModel> equipmentList = responseData
            .map((item) => EquipmentCategoryResponseModel.fromJson(item))
            .toList();
        _logger
            .info('Request successful, received ${equipmentList.length} items');
        return equipmentList;
      } else {
        _logger
            .info('Failed to get equipment by system: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      _logger.info('Error during get all equipment by system: $e');
      return [];
    }
  }
}
