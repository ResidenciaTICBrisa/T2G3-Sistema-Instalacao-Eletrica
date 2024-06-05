class FireAlarmEquipmentRequestModel {
  String name;
  int? system;

  FireAlarmEquipmentRequestModel({
    required this.name,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'system': system,
    };
  }

  factory FireAlarmEquipmentRequestModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmEquipmentRequestModel(
      name: json['name'],
      system: json['system'],
    );
  }
}
