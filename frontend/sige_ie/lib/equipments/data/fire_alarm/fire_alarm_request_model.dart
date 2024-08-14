class FireAlarmRequestModel {
  int? area;
  int? system;
  int? quantity;
  String? observation;

  FireAlarmRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.observation});

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'observation': observation
    };
  }
}
