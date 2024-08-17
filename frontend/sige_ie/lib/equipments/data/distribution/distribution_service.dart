import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/equipments/data/distribution/distribution_request_model.dart';
import 'package:sige_ie/equipments/data/distribution/distribution_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/distribution/distribution_response_model.dart';
import 'package:sige_ie/main.dart';

class DistributionEquipmentService {
  final Logger _logger = Logger('DistributionEquipmentService');
  final String baseUrl = '$urlUniversal/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<DistributionEquipmentResponseByAreaModel>>
      getDistributionListByArea(int areaId) async {
    var url = Uri.parse('${baseUrl}distribution-boards/by-area/$areaId/');
    try {
      var response = await client.get(url);
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        return dataList
            .map((data) =>
                DistributionEquipmentResponseByAreaModel.fromJson(data))
            .toList();
      } else {
        _logger.info(
            'Failed to load distribution boards equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to load distribution boards equipment');
      }
    } catch (e) {
      _logger.info('Error during get distribution boards equipment list: $e');
      throw Exception('Failed to load distribution boards equipment');
    }
  }

  Future<void> deleteDistribution(int DistributionId) async {
    var url = Uri.parse('${baseUrl}distribution-boards/$DistributionId/');
    try {
      var response = await client.delete(url);
      if (response.statusCode == 204) {
        _logger.info(
            'Successfully deleted distribution boards equipment with ID: $DistributionId');
      } else {
        _logger.info(
            'Failed to delete distribution boards equipment with status code: ${response.statusCode}');
        _logger.info('Response body: ${response.body}');
        throw Exception('Failed to delete distribution boards equipment');
      }
    } catch (e) {
      _logger.info('Error during delete distribution boards equipment: $e');
      throw Exception('Failed to delete distribution boards equipment');
    }
  }

  Future<DistributionResponseModel> getDistributionById(
      int DistributionId) async {
    var url = Uri.parse('${baseUrl}distribution-boards/$DistributionId/');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return DistributionResponseModel.fromJson(jsonResponse);
      } else {
        _logger.info(
            'Failed to load distribution boards with status code: ${response.statusCode}');
        throw Exception('Failed to load distribution boards');
      }
    } catch (e) {
      _logger.info('Error during get distribution boards: $e');
      throw Exception('Failed to load distribution boards');
    }
  }

  Future<bool> updateDistribution(int DistributionId,
      DistributionRequestModel DistributionIdRequestModel) async {
    var url = Uri.parse('${baseUrl}distribution-boards/$DistributionId/');

    try {
      var response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(DistributionIdRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        _logger.info(
            'Successfully updated distribution boards equipment with ID: $DistributionId');
        return true;
      } else {
        _logger.info(
            'Failed to update distribution boards equipment with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.info('Error during update distribution boards equipment: $e');
      return false;
    }
  }
}
