class IluminationEquipmentResponseByAreaModel {
  final int id;
  final int area;
  final String equipmentCategory;
  final int system;
  final int quantity;
  final String observation;

  IluminationEquipmentResponseByAreaModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
    required this.quantity,
    required this.observation,
  });

  factory IluminationEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return IluminationEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
      observation: json['observation'],
    );
  }
}
