class EletricalLineEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  String? observation;

  EletricalLineEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.equipmentCategory,
      required this.system,
      required this.quantity,
      required this.observation});

  factory EletricalLineEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLineEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
      observation: json['observation'],
    );
  }
}
