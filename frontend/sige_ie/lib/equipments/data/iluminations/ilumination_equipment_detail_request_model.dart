import 'package:sige_ie/equipments/data/iluminations/ilumination_request_model.dart';
import 'package:sige_ie/equipments/data/photo/photo_request_model.dart';

class FireAlarmEquipmentDetailRequestModel {
  int? equipmenteType;
  IluminationRequestModel? ilumination;
  List<PhotoRequestModel>? photos;

  FireAlarmEquipmentDetailRequestModel({
    required this.equipmenteType,
    required this.ilumination,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'equipmenteType': equipmenteType,
      'ilumination_equipment': ilumination?.toJson(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
