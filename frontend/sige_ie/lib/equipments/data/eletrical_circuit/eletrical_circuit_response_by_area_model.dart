class EletricalCircuitEquipmentResponseByAreaModel {
  int id;
  int area;
  int system;
  int size;
  String equipmentCategory;
  String type_wire;
  String type_circuit_breaker;
  String? observation;

  EletricalCircuitEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.system,
      required this.size,
      required this.equipmentCategory,
      required this.observation,
      required this.type_wire,
      required this.type_circuit_breaker});

  factory EletricalCircuitEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalCircuitEquipmentResponseByAreaModel(
        id: json['id'],
        area: json['area'],
        system: json['system'],
        size: json['size'],
        equipmentCategory: json['equipment_category'],
        observation: json['observation'],
        type_wire: json['type_wire'],
        type_circuit_breaker: json['type_circuit_breaker']);
  }
}
