import 'package:sige_ie/equipments/data/eletrical_line/eletrical_line_request_model.dart';

class EletricalLineEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  EletricalLineRequestModel? eletricalLineRequestModel;

  EletricalLineEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.eletricalLineRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'electrical_line_equipment': eletricalLineRequestModel?.toJson(),
    };
  }
}
