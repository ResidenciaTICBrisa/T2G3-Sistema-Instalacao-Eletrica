class EletricalLoadResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  int power;
  String brand;
  String model;
  String? observation;

  EletricalLoadResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.power,
      required this.brand,
      required this.model,
      required this.observation});

  factory EletricalLoadResponseModel.fromJson(Map<String, dynamic> json) {
    return EletricalLoadResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        power: json['power'],
        brand: json['brand'],
        model: json['model'],
        observation: json['observation']);
  }
}
