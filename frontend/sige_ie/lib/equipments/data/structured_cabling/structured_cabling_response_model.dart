class StructuredCablingEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  StructuredCablingEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory StructuredCablingEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return StructuredCablingEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
