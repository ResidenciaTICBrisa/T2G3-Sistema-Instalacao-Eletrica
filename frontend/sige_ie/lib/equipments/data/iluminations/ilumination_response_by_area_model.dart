class IluminationEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  int power;
  String tecnology;
  String format;

  IluminationEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.equipmentCategory,
      required this.system,
      required this.quantity,
      required this.format,
      required this.power,
      required this.tecnology});

  factory IluminationEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return IluminationEquipmentResponseByAreaModel(
        id: json['id'],
        area: json['area'],
        equipmentCategory: json['equipment_category'],
        system: json['system'],
        quantity: json['quantity'],
        format: json['format'],
        power: json['power'],
        tecnology: json['tecnology']);
  }
}
