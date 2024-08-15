class EletricalCircuitResponseModel {
  int id;
  int area;
  int system;
  int size;
  int equipment;
  String type_wire;
  String type_circuit_breaker;
  String? observation;

  EletricalCircuitResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.size,
      required this.observation,
      required this.type_wire,
      required this.type_circuit_breaker});

  factory EletricalCircuitResponseModel.fromJson(Map<String, dynamic> json) {
    return EletricalCircuitResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        size: json['size'],
        observation: json['observation'],
        type_wire: json['type_wire'],
        type_circuit_breaker: json['type_circuit_breaker']);
  }
}
