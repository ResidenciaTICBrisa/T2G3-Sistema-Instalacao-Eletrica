class IluminationResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  int power;
  String tecnology;
  String format;

  IluminationResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.format,
      required this.power,
      required this.tecnology});

  factory IluminationResponseModel.fromJson(Map<String, dynamic> json) {
    return IluminationResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        format: json['format'],
        power: json['power'],
        tecnology: json['tecnology']);
  }
}
