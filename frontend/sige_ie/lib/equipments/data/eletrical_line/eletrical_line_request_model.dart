class EletricalLineRequestModel {
  /* obs */
  int? area;
  int? system;
  int? quantity;

  EletricalLineRequestModel(
      {required this.area, required this.system, this.quantity});

  Map<String, dynamic> toJson() {
    return {'area': area, 'system': system, 'quantity': quantity};
  }
}
