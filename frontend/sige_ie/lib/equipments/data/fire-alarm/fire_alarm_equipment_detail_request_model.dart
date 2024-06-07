import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_request_model.dart';
import 'package:sige_ie/equipments/data/photo/photo_request_model.dart';

class FireAlarmEquipmentDetailRequestModel {
  int? equipmentType;
  FireAlarmRequestModel? fireAlarm;
  List<PhotoRequestModel>? photos;

  FireAlarmEquipmentDetailRequestModel({
    required this.equipmentType,
    required this.fireAlarm,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'equipmentType': equipmentType,
      'fire_alarm_equipment': fireAlarm?.toJson(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
