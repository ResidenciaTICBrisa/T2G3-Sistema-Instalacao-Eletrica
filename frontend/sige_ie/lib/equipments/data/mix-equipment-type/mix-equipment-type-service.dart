import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sige_ie/core/data/auth_interceptor.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_response_model.dart';
import 'package:sige_ie/main.dart';

class MixEquipmentTypeService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  http.Client client = InterceptedClient.build(
    interceptors: [AuthInterceptor(cookieJar)],
  );

  Future<List<EquipmentTypeResponseModel>> getAllEquipmentBySystem(
      int systemId, equipmentTypeList, personalEquipmentList) async {
    try {
      List<EquipmentTypeResponseModel> combinedList = [
        ...equipmentTypeList,
        ...personalEquipmentList,
      ];
      print('Combined list length: ${combinedList.length}');
      return combinedList;
    } catch (e) {
      print('Error during get all equipment: $e');
      return [];
    }
  }
}
