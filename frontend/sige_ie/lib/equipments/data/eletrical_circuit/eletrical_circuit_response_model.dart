class EletricalCircuitEquipmentResponseModel {
  int id;
  String area;
  int system;

  EletricalCircuitEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory EletricalCircuitEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalCircuitEquipmentResponseModel(
      id: json['id'],
      area: json['name'],
      system: json['system'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'system': system,
    };
  }
}
