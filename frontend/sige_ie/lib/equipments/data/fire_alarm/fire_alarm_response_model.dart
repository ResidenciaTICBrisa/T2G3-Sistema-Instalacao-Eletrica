class FireAlarmEquipmentResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;

  FireAlarmEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
  });

  factory FireAlarmEquipmentResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
