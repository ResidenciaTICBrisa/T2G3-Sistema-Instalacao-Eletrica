import 'package:sige_ie/equipments/data/iluminations/ilumination_request_model.dart';

class IluminationEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  IluminationRequestModel? iluminationRequestModel;

  IluminationEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.iluminationRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'ilumination_equipment': iluminationRequestModel?.toJson(),
    };
  }
}
