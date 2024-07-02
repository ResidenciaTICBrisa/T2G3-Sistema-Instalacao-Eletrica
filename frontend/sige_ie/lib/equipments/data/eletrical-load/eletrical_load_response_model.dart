class EletricalLoadEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  EletricalLoadEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory EletricalLoadEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLoadEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
