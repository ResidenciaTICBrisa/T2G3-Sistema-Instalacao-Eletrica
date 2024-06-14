import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_request_model.dart';
import 'package:sige_ie/shared/data/equipment-photo/photo_request_model.dart';

class FireAlarmEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  FireAlarmRequestModel? fireAlarm;
  List<EquipmentPhotoRequestModel>? photos;

  FireAlarmEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.fireAlarm,
    required this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'fire_alarm_equipment': fireAlarm?.toJson(),
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}
