class EletricalCircuitEquipmentResponseByAreaModel {
  int id;
  int area;
  int system;
  int quantity;
  int size;
  String equipmentCategory;
  String isolamento;

  EletricalCircuitEquipmentResponseByAreaModel(
      {required this.id,
      required this.area,
      required this.system,
      required this.quantity,
      required this.size,
      required this.equipmentCategory,
      required this.isolamento});

  factory EletricalCircuitEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalCircuitEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      system: json['system'],
      quantity: json['quantity'],
      size: json['size'],
      equipmentCategory: json['equipment_category'],
      isolamento: json['isolamento'],
    );
  }
}
