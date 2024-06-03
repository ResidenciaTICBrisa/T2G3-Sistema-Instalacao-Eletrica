from .views import *
from django.urls import path

urlpatterns = [
    path('personal-equipment-types/', PersonalEquipmentTypeCreate.as_view(), name='personal_equipment_types'),
    path('personal-equipment-types/by-system/<int:system_id>/', PersonalEquipmentTypeList.as_view(), name='personal_equipment_types_by_system'),
    path('personal-equipment-types/<pk>/', PersonalEquipmentTypeDetail.as_view()),
    path('equipment-types/by-system/<int:system_id>/', EquipmentTypeList.as_view(), name='personal_equipment_types_by_system'),
    path('equipment-types/<pk>/', EquipmentTypeDetail.as_view()),
    path('equipment-details/', EquipmentDetailCreate.as_view(), name='equipment-detail-create'),
    path('equipment-details/', EquipmentDetailList.as_view()),
    path('equipment-details/<pk>/', EquipmentDetailDetail.as_view()),
    path('equipment-photos/', EquipmentPhotoList.as_view()),
    path('equipment-photos/<pk>/', EquipmentPhotoDetail.as_view()),
    path('refrigerations/', RefrigerationEquipmentList.as_view()),
    path('refrigeration/by-area/<int:area_id>/', RefrigerationEquipmentByAreaList.as_view()),
    path('refrigerations/<pk>/', RefrigerationEquipmentDetail.as_view()),
    path('fire-alarms/', FireAlarmEquipmentList.as_view()),
    path('fire-alarms/by-area/<int:area_id>/', FireAlarmEquipmentByAreaList.as_view()),
    path('fire-alarms/<pk>/', FireAlarmEquipmentDetail.as_view()),
    path('atmospheric-discharges/', AtmosphericDischargeEquipmentList.as_view()),
    path('atmospheric-discharges/by-area/<int:area_id>/', AtmosphericDischargeEquipmentByAreaList.as_view()),
    path('atmospheric-discharges/<pk>/', AtmosphericDischargeEquipmentDetail.as_view()),
    path('structured-cabling/', StructuredCablingEquipmentList.as_view()),
    path('structured-cabling/by-area/<int:area_id>/', StructuredCablingEquipmentByAreaList.as_view()),
    path('structured-cabling/<pk>/', StructuredCablingEquipmentDetail.as_view()),
    path('distribution-boards/', DistributionBoardEquipmentList.as_view()),
    path('distribution-boards/by-area/<int:area_id>/', DistributionBoardEquipmentByAreaList.as_view()),
    path('distribution-boards/<pk>/', DistributionBoardEquipmentDetail.as_view()),
    path('electrical-circuits/', ElectricalCircuitEquipmentList.as_view()),
    path('electrical-circuits/by-area/<int:area_id>/',  ElectricalCircuitEquipmentByAreaList.as_view()),
    path('electrical-circuits/<pk>/', ElectricalCircuitEquipmentDetail.as_view()),
    path('electrical-lines/', ElectricalLineEquipmentList.as_view()),
    path('electrical-lines/by-area/<int:area_id>/',  ElectricalLineEquipmentByAreaList.as_view()),
    path('electrical-lines/<pk>/', ElectricalLineEquipmentDetail.as_view()),
    path('electrical-loads/', ElectricalLoadEquipmentList.as_view()),
    path('electrical-loads/by-area/<int:area_id>/',  ElectricalLoadEquipmentByAreaList.as_view()),
    path('electrical-loads/<pk>/', ElectricalLoadEquipmentDetail.as_view()),
    path('iluminations/', IluminationEquipmentList.as_view()),
    path('iluminations/by-area/<int:area_id>/', IluminationEquipmentByAreaList.as_view()),
    path('iluminations/<pk>/', IluminationEquipmentDetail.as_view())
]
