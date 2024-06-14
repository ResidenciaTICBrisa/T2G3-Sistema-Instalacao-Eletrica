class PersonalEquipmentCategoryRequestModel {
  String name;
  int? system;

  PersonalEquipmentCategoryRequestModel({
    required this.name,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'system': system,
    };
  }
}
