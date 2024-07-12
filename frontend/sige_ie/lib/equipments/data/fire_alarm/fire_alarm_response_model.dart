class FireAlarmEquipmentResponseModel {
  int id;
  int area;
  int equipment;
  int system;

  FireAlarmEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
  });

  factory FireAlarmEquipmentResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
    );
  }
}
