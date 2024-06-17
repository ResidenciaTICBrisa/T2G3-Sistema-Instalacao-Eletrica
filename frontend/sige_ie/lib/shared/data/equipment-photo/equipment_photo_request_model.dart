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
  }

  Map<String, dynamic> toJson() {
    return {
      'photo': photoBase64,
      'description': description,
      'equipment': equipment,
    };
  }
}
