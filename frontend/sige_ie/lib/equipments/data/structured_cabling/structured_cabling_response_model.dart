class StructuredCablingResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;

  StructuredCablingResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
  });

  factory StructuredCablingResponseModel.fromJson(Map<String, dynamic> json) {
    return StructuredCablingResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
