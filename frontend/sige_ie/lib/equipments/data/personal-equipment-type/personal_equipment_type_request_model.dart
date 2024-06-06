class PersonalEquipmentTypeRequestModel {
  String name;
  int? system;

  PersonalEquipmentTypeRequestModel({
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
