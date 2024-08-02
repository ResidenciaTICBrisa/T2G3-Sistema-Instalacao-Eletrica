class DistributionEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  String? power;
  bool dr;
  bool dps;
  bool grounding;
  String? typeMaterial;
  String? methodInstallation;

  DistributionEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.equipmentCategory,
      required this.system,
      required this.quantity,
      required this.power,
      required this.dr,
      required this.dps,
      required this.grounding,
      required this.typeMaterial,
      required this.methodInstallation});

  factory DistributionEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return DistributionEquipmentResponseByAreaModel(
        id: json['id'],
        area: json['area'],
        equipmentCategory: json['equipment_category'],
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
