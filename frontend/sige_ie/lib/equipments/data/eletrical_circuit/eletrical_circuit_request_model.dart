class EletricalCircuitRequestModel {
  int? area;
  int? system;
  int? quantity;
  int? size;
  String isolamento;
  EletricalCircuitRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.size,
      required this.isolamento});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'size': size,
      'isolamento': isolamento
    };
  }
}
