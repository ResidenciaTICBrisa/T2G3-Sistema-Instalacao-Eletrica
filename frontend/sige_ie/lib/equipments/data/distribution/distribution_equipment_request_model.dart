import 'package:sige_ie/equipments/data/distribution/distribution_request_model.dart';

class DistributionEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  DistributionRequestModel? distributionRequestModel;

  DistributionEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.distributionRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'structured_cabling_equipment': distributionRequestModel?.toJson(),
    };
  }
}
