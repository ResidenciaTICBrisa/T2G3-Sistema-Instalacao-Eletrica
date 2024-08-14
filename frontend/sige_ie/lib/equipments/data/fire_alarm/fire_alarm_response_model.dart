class FireAlarmResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  String? observation;

  FireAlarmResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.observation});

  factory FireAlarmResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        observation: json['observation']);
  }
}
