class StructuredCablingResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  int? power;
  String tecnology;
  String format;

  StructuredCablingResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.format,
      required this.power,
      required this.tecnology});

  factory StructuredCablingResponseModel.fromJson(Map<String, dynamic> json) {
    return StructuredCablingResponseModel(
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
