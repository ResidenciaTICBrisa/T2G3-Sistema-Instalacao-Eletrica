class AtmosphericEquipmentRequestModel {
  List<String> photos;
  int area;
  int system;
  int equipmentType;

  AtmosphericEquipmentRequestModel({
    required this.photos,
    required this.area,
    required this.system,
    required this.equipmentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'photos': photos,
      'area': area,
      'system': system,
      'equipmentType': equipmentType,
    };
  }

  factory AtmosphericEquipmentRequestModel.fromJson(Map<String, dynamic> json) {
    return AtmosphericEquipmentRequestModel(
      photos: List<String>.from(json['photos'] ?? []),
      area: json['area'],
      system: json['system'],
      equipmentType: json['equipmentType'],
    );
  }
}
