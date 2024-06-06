class FireAlarmEquipmentResponseModel {
  int id;
  String name;
  int system;

  FireAlarmEquipmentResponseModel({
    required this.id,
    required this.name,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'system': system,
    };
  }

  factory FireAlarmEquipmentResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmEquipmentResponseModel(
      id: json['id'],
      name: json['name'],
      system: json['system'],
    );
  }
}
