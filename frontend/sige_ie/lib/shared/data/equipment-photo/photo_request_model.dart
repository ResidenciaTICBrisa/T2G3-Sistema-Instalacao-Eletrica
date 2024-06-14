class EquipmentPhotoRequestModel {
  String photo;
  String description;

  EquipmentPhotoRequestModel({
    required this.photo,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'description': description,
    };
  }
}
