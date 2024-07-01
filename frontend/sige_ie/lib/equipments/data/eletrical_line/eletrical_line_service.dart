import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/main.dart';

class EletricalLineEquipmentService {
  final Logger _logger = Logger('EletricalLineEquipmentService');
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<String>> getElectricalLineListByArea(int areaId) async {
    final url = '${baseUrl}electrical-lines/by-area/$areaId';
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _logger.info('API response data: $data');
        return data.map((item) {
          if (item['equipment'].containsKey('generic_equipment_category')) {
            return item['equipment']['generic_equipment_category'] as String;
          } else if (item['equipment']
              .containsKey('personal_equipment_category')) {
            return item['equipment']['personal_equipment_category'] as String;
          } else {
            return 'Unknown Equipment';
          }
        }).toList();
      } else {
        throw Exception('Failed to load electrical-lines equipment');
      }
    } catch (e) {
      _logger.info('Error during get electrical-lines equipment list: $e');
      return [];
    }
  }
}
