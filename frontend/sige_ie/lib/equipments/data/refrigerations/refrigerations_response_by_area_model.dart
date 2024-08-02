class RefrigerationsEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  int power;

  RefrigerationsEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.equipmentCategory,
      required this.system,
      required this.quantity,
      required this.power});

  factory RefrigerationsEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return RefrigerationsEquipmentResponseByAreaModel(
        id: json['id'],
        area: json['area'],
        equipmentCategory: json['equipment_category'],
        system: json['system'],
        quantity: json['quantity'],
        power: json['power']);
  }
}
