class EletricalLineEquipmentResponseModel {
  int id;
  String area;
  int system;

  EletricalLineEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory EletricalLineEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLineEquipmentResponseModel(
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
