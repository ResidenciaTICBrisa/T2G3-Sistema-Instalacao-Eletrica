class IluminationRequestModel {
  int? area;
  int? system;
  int? quantity;
  int? power;
  String tecnology;
  String format;

  IluminationRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.format,
      required this.power,
      required this.tecnology});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'format': format,
      'power': power,
      'tecnology': tecnology
    };
  }
}
