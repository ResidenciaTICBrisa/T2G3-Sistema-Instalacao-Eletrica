class IluminationRequestModel {
  int? area;
  int? system;
  int? quantity;
  int? power;
  String? tecnology;
  String? format;
  String? observation;

  IluminationRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.format,
      required this.power,
      required this.tecnology,
      required this.observation});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'format': format,
      'power': power,
      'tecnology': tecnology,
      'observation': observation
    };
  }
}
