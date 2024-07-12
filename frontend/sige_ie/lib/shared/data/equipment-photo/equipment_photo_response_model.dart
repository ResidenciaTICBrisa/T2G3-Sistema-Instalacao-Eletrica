import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class EquipmentPhotoResponseModel {
  int id;
  String? photoBase64;
  String? description;
  int? equipment;

  EquipmentPhotoResponseModel({
    required this.id,
    required this.photoBase64,
    required this.description,
    required this.equipment,
  });

  factory EquipmentPhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return EquipmentPhotoResponseModel(
      id: json['id'],
      photoBase64: json['photo_base64'],
      description: json['description'],
      equipment: json['equipment'],
    );
  }

  Future<File> toFile() async {
    Uint8List bytes = base64Decode(photoBase64!.split(',')[1]);
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/photo_$id.jpg';
    File file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }
}
