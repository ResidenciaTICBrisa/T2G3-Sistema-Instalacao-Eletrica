class StructuredCablingEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;

  StructuredCablingEquipmentResponseByAreaModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
    required this.quantity,
  });

  factory StructuredCablingEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return StructuredCablingEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
