import 'package:sige_ie/equipments/data/refrigerations/refrigerations_request_model.dart';

class RefrigerationsEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  RefrigerationsRequestModel? refrigerationsRequestModel;

  RefrigerationsEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.refrigerationsRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'refrigeration_equipment': refrigerationsRequestModel?.toJson(),
    };
  }
}
