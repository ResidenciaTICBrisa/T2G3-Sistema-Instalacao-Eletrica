class RefrigerationsEquipmentResponseModel {
  int id;
  String area;
  int system;

  RefrigerationsEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory RefrigerationsEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return RefrigerationsEquipmentResponseModel(
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
