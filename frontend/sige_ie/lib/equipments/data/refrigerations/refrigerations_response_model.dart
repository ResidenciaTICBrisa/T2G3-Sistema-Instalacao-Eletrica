class RefrigerationsEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  RefrigerationsEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory RefrigerationsEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return RefrigerationsEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
