class StructuredCablingRequestModel {
  int? area;
  int? system;
  int? quantity;

  StructuredCablingRequestModel(
      {required this.area, required this.system, this.quantity});

  Map<String, dynamic> toJson() {
    return {'area': area, 'system': system, 'quantity': quantity};
  }
}
