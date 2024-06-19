class IluminationEquipmentResponseModel {
  int id;
  String area;
  int system;

  IluminationEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory IluminationEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return IluminationEquipmentResponseModel(
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
