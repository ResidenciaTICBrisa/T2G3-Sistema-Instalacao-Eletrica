class EquipmentCategoryResponseModel {
  int id;
  String name;
  int system;

  EquipmentCategoryResponseModel({
    required this.id,
    required this.name,
    required this.system,
  });

  factory EquipmentCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return EquipmentCategoryResponseModel(
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
