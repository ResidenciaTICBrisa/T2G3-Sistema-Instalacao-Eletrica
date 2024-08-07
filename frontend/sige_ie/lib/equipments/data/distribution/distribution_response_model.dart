class DistributionResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  String? power;
  bool dr;
  bool dps;
  bool grounding;
  String? typeMaterial;
  String? methodInstallation;

  DistributionResponseModel(
      {required this.id,
      required this.area,
      required this.equipment,
      required this.system,
      required this.quantity,
      required this.power,
      required this.dr,
      required this.dps,
      required this.grounding,
      required this.typeMaterial,
      required this.methodInstallation});

  factory DistributionResponseModel.fromJson(Map<String, dynamic> json) {
    return DistributionResponseModel(
        id: json['id'],
        area: json['area'],
        equipment: json['equipment'],
        system: json['system'],
        quantity: json['quantity'],
        power: json['power'],
        dr: json['dr'],
        dps: json['dps'],
        grounding: json['grounding'],
        typeMaterial: json['typeMaterial'],
        methodInstallation: json['methodInstallation']);
  }
}
