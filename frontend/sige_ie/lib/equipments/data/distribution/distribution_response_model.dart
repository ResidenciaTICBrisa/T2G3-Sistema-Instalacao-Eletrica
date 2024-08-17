class DistributionResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;
  int power;
  bool dr;
  bool dps;
  bool grounding;
  String typeMaterial;
  String methodInstallation;
  String? observation;

  DistributionResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
    required this.power,
    required this.dr,
    required this.dps,
    required this.grounding,
    required this.typeMaterial,
    required this.methodInstallation,
    this.observation,
  });

  factory DistributionResponseModel.fromJson(Map<String, dynamic> json) {
    return DistributionResponseModel(
      id: json['id'] ?? 0,
      area: json['area'] ?? 0,
      equipment: json['equipment'] ?? 0,
      system: json['system'] ?? 0,
      quantity: json['quantity'] ?? 0,
      power: json['power'] ?? 0,
      dr: json['dr'] ?? false,
      dps: json['dps'] ?? false,
      grounding: json['grounding'] ?? false,
      typeMaterial: json['type_material'] ?? '', // Corrigido para type_material
      methodInstallation: json['method_installation'] ??
          '', // Corrigido para method_installation
      observation: json['observation'], // Nullable, sem valor padrão
    );
  }
}
