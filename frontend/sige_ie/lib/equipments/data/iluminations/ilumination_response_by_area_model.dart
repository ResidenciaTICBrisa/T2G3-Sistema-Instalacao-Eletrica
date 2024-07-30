class IluminationEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;

  IluminationEquipmentResponseByAreaModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
    required this.quantity,
  });

  factory IluminationEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return IluminationEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
