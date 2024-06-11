class EquipmentTypeResponseModel {
  int id;
  String name;
  int system;

  EquipmentTypeResponseModel({
    required this.id,
    required this.name,
    required this.system,
  });

  factory EquipmentTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return EquipmentTypeResponseModel(
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
