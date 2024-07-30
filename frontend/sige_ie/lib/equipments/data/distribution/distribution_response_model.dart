class DistributionResponseModel {
  int id;
  int area;
  int equipment;
  int system;
  int quantity;

  DistributionResponseModel({
    required this.id,
    required this.area,
    required this.equipment,
    required this.system,
    required this.quantity,
  });

  factory DistributionResponseModel.fromJson(Map<String, dynamic> json) {
    return DistributionResponseModel(
      id: json['id'],
      area: json['area'],
      equipment: json['equipment'],
      system: json['system'],
      quantity: json['quantity'],
    );
  }
}
