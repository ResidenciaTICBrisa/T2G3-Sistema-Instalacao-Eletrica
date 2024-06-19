import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_request_model.dart';

class EletricalCircuitEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  EletricalCircuitRequestModel? eletricalCircuitRequestModel;

  EletricalCircuitEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.eletricalCircuitRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'electrical_circuit_equipment': eletricalCircuitRequestModel?.toJson(),
    };
  }
}
