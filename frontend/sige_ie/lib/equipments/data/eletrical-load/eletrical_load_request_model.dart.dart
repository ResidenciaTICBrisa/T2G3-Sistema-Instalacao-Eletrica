class EletricalLoadRequestModel {
  int? area;
  int? system;
  int? quantity;
  double? power;
  String? brand;
  String? model;
  String? observation;

  EletricalLoadRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.power,
      required this.brand,
      required this.model,
      required this.observation});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'power': power,
      'brand': brand,
      'model': model,
      'observation': observation
    };
  }
}
