from .views import *
from django.urls import path

urlpatterns = [
    path('equipment-type/', EquipmentTypeList.as_view()),
    path('equipment-type/<pk>/', EquipmentTypeDetail.as_view()),
    path('equipments/', EquipmentDetailList.as_view()),
    path('equipments/<pk>/', EquipmentDetailDetail.as_view()),
    path('atmospheric-discharges/', AtmosphericDischargeEquipmentList.as_view()),
    path('atmospheric-discharges/<pk>/', AtmosphericDischargeEquipmentDetail.as_view()),
    path('fire-alarms/', FireAlarmEquipmentList.as_view()),
    path('fire-alarms/<pk>/', FireAlarmEquipmentDetail.as_view()),
    path('sructered-cabling/', SructeredCablingEquipmentList.as_view()),
    path('sructered-cabling/<pk>/', SructeredCablingEquipmentDetail.as_view()),
    path('distribution-boards/', DistributionBoardEquipmentList.as_view()),
    path('distribution-boards/<pk>/', DistributionBoardEquipmentDetail.as_view()),
    path('electrical-circuits/', ElectricalCircuitEquipmentList.as_view()),
    path('electrical-circuits/<pk>/', ElectricalCircuitEquipmentDetail.as_view()),
    path('electrical-lines/', ElectricalLineEquipmentList.as_view()),
    path('electrical-lines/<pk>/', ElectricalLineEquipmentDetail.as_view()),
    path('electrical-loads/', ElectricalLoadEquipmentList.as_view()),
    path('electrical-loads/<pk>/', ElectricalLoadEquipmentDetail.as_view()),
    path('iluminations/', IluminationEquipmentList.as_view()),
    path('iluminations/<pk>/', IluminationEquipmentDetail.as_view())

]
