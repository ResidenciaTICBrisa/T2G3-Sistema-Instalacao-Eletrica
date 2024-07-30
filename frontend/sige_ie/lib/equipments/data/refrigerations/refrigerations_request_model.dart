class RefrigerationsRequestModel {
  int? area;
  int? system;
  int? quantity;
  int? power;

  RefrigerationsRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.power});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'power': power
    };
  }
}
