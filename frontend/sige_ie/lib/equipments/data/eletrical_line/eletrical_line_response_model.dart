class EletricalLineEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  EletricalLineEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory EletricalLineEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLineEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
