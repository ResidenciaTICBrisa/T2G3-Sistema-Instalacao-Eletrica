class FireAlarmResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;

  FireAlarmResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
  });

  factory FireAlarmResponseModel.fromJson(Map<String, dynamic> json) {
    return FireAlarmResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
