class IluminationEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  IluminationEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory IluminationEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return IluminationEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
