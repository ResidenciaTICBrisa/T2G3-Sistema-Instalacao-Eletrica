class FireAlarmEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  FireAlarmEquipmentResponseByAreaModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory FireAlarmEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return FireAlarmEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
