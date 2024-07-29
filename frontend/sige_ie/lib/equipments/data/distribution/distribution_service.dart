import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/main.dart';

class DistributionEquipmentService {
  final Logger _logger = Logger('DistributionEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<String>> getDistributionListByArea(int areaId) async {
    final url = '${baseUrl}distribution-boards/by-area/$areaId';
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
        throw Exception('Failed to load distribution-boards equipment');
      }
    } catch (e) {
      _logger.info('Error during get distribution-boards equipment list: $e');
      return [];
    }
  }
}
