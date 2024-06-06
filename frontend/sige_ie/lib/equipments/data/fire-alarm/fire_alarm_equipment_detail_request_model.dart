import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_request_model.dart';
import 'package:sige_ie/equipments/data/photo/photo_request_model.dart';

class FireAlarmEquipmentDetailRequestModel {
  int? equipmenteType;
  FireAlarmRequestModel? fireAlarm;
  List<PhotoRequestModel>? photos;

  FireAlarmEquipmentDetailRequestModel({
    required this.equipmenteType,
    required this.fireAlarm,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'equipmenteType': equipmenteType,
      'fire_alarm_equipment': fireAlarm?.toJson(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
