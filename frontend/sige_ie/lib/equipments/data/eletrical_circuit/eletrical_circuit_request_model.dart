class EletricalCircuitRequestModel {
  int? area;
  int? system;
  int? size;
  String? type_wire;
  String? type_circuit_breaker;
  String? observation;
  EletricalCircuitRequestModel(
      {required this.area,
      required this.system,
      required this.size,
      required this.type_wire,
      required this.type_circuit_breaker,
      required this.observation});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'size': size,
      'observation': observation,
      'type_wire': type_wire,
      'type_circuit_breaker': type_circuit_breaker
    };
  }
}
