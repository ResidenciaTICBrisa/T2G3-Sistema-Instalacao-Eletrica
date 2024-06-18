import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_request_model.dart.dart';

class EletricalLoadEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  EletricalLoadRequestModel? eletricalLoadRequestModel;

  EletricalLoadEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.eletricalLoadRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'electrical_load_equipment': eletricalLoadRequestModel?.toJson(),
    };
  }
}
