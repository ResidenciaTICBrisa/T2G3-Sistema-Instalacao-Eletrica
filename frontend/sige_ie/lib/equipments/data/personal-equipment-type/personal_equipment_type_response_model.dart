class PersonalEquipmentTypeResponseModel {
  int id;
  String name;
  int system;

  PersonalEquipmentTypeResponseModel({
    required this.id,
    required this.name,
    required this.system,
  });

  factory PersonalEquipmentTypeResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PersonalEquipmentTypeResponseModel(
      id: json['id'],
      name: json['name'],
      system: json['system'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'system': system,
    };
  }
}
