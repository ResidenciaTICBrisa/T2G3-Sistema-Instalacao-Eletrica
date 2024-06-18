class AtmosphericEquipmentResponseModel {
  int id;
  String area;
  int system;

  AtmosphericEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory AtmosphericEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AtmosphericEquipmentResponseModel(
      id: json['id'],
      area: json['name'],
      system: json['system'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'system': system,
    };
  }
}
