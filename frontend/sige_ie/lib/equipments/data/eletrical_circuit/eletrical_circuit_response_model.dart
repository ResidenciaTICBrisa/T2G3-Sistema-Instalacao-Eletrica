class EletricalCircuitResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  int size;
  String isolament;

  EletricalCircuitResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.size,
      required this.isolament});

  factory EletricalCircuitResponseModel.fromJson(Map<String, dynamic> json) {
    return EletricalCircuitResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        size: json['size'],
        isolament: json['isolament']);
  }
}
