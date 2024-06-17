import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_request_model.dart';

class FireAlarmEquipmentRequestModel {
  int? genericEquipmentCategory;
  int? personalEquipmentCategory;
  FireAlarmRequestModel? fireAlarmRequestModel;

  FireAlarmEquipmentRequestModel({
    required this.genericEquipmentCategory,
    required this.personalEquipmentCategory,
    required this.fireAlarmRequestModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'generic_equipment_category': genericEquipmentCategory,
      'personal_equipment_category': personalEquipmentCategory,
      'fire_alarm_equipment': fireAlarmRequestModel?.toJson(),
    };
  }
}
