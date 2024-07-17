import 'package:sige_ie/equipments/data/distribution/distribution_request_model.dart';

class DistributionEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  DistributionRequestModel? distributionRequestModel;
  String? power;
  bool dr;
  bool dps;
  bool grounding;
  String? typeMaterial;
  String? methodInstallation;

  DistributionEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.distributionRequestModel,
    this.power,
    this.dr = false,
    this.dps = false,
    this.grounding = false,
    this.typeMaterial,
    this.methodInstallation,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'distribution_board_equipment': distributionRequestModel?.toJson(),
      'power': power,
      'dr': dr,
      'dps': dps,
      'grounding': grounding,
      'type_material': typeMaterial,
      'method_installation': methodInstallation,
    };
  }
}
