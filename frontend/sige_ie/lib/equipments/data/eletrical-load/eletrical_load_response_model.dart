class EletricalLoadEquipmentResponseModel {
  int id;
  String area;
  int system;

  EletricalLoadEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory EletricalLoadEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalLoadEquipmentResponseModel(
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
