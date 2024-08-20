class StructuredCablingResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  String? observation;

  StructuredCablingResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.observation});

  factory StructuredCablingResponseModel.fromJson(Map<String, dynamic> json) {
    return StructuredCablingResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        observation: json['observation']);
  }
}
