class DistributionRequestModel {
  /* Obs e power = int? */
  int? area;
  int? system;
  int? quantity;
  int? power;
  bool dr;
  bool dps;
  bool grounding;
  String? typeMaterial;
  String? methodInstallation;

  DistributionRequestModel(
      {required this.area,
      required this.system,
      required this.quantity,
      required this.power,
      required this.dr,
      required this.dps,
      required this.grounding,
      required this.typeMaterial,
      required this.methodInstallation});
  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
      'quantity': quantity,
      'power': power,
      'dr': dr,
      'dps': dps,
      'grounding': grounding,
      'type_material': typeMaterial,
      'method_installation': methodInstallation,
    };
  }
}
