import 'package:sige_ie/equipments/data/atmospheric/atmospheric_request_model.dart';

class AtmosphericEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  AtmosphericRequestModel? atmosphericRequestModel;

  AtmosphericEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.atmosphericRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'atmospheric_discharge_equipment': atmosphericRequestModel?.toJson(),
    };
  }
}
