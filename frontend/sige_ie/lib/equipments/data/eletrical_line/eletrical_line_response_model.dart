class EletricalLineResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  String? observation;

  EletricalLineResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.observation});

  factory EletricalLineResponseModel.fromJson(Map<String, dynamic> json) {
    return EletricalLineResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        observation: json['observation']);
  }
}
