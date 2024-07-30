class EletricalLineResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;

  EletricalLineResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
  });

  factory EletricalLineResponseModel.fromJson(Map<String, dynamic> json) {
    return EletricalLineResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
