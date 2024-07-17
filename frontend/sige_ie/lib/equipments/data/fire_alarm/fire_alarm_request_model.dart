class FireAlarmRequestModel {
  int? area;
  int? system;
  int? quantity;

  FireAlarmRequestModel({
    required this.area,
    required this.system,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
    };
  }
}
