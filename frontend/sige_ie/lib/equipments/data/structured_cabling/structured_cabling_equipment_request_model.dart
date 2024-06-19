import 'package:sige_ie/equipments/data/structured_cabling/structured_cabling_request_model.dart';

class StructuredCablingEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  StructuredCablingRequestModel? structuredCablingRequestModel;

  StructuredCablingEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.structuredCablingRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'structured_cabling_equipment': structuredCablingRequestModel?.toJson(),
    };
  }
}
