class EletricalLoadEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  int? power;
  String? brand;
  String? model;

  EletricalLoadEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.equipmentCategory,
      required this.system,
      required this.quantity,
      required this.power,
      required this.brand,
      required this.model});

  factory EletricalLoadEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLoadEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
      power: json['power'],
      brand: json['brand'],
      model: json['model'],
    );
  }
}
