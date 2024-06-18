class StructuredCablingEquipmentResponseModel {
  int id;
  String area;
  int system;

  StructuredCablingEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory StructuredCablingEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return StructuredCablingEquipmentResponseModel(
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
