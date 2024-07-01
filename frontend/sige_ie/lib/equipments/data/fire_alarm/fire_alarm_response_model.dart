class FireAlarmEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  FireAlarmEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory FireAlarmEquipmentResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
