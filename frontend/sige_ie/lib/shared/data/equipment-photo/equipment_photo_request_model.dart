import 'dart:io';
import 'dart:convert';

class EquipmentPhotoRequestModel {
  String? photoBase64;
  String? description;
  int? equipment;

  EquipmentPhotoRequestModel({
    required File photo,
    required this.description,
    required this.equipment,
  }) {
    String base64Image = base64Encode(photo.readAsBytesSync());
    photoBase64 = 'data:image/jpeg;base64,$base64Image';
    print(
        'Created EquipmentPhotoRequestModel: photoBase64: $photoBase64, description: $description, equipment: $equipment');
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'photo': photoBase64,
      'description': description,
      'equipment': equipment,
    };
    print('EquipmentPhotoRequestModel toJson: $json');
    return json;
  }
}
