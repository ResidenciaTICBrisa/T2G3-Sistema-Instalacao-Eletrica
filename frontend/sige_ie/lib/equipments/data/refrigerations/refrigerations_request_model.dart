class RefrigerationsRequestModel {
  int? area;
  int? system;
  int? quantity;
  int? power;
  String? observation;
  RefrigerationsRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.power,
      required this.observation});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'power': power,
      'observation': observation
    };
  }
}
