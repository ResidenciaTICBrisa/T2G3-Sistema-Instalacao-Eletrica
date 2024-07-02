class AtmosphericEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  AtmosphericEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory AtmosphericEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AtmosphericEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
