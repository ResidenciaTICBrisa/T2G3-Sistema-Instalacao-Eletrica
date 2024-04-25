from django.db import models
from places.models import Area
from systems.models import System
from users.models import PlaceOwner

class EquipmentType(models.Model):
    name = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'equipments_equipment_types'

class EquipmentDetail(models.Model):
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)
    equipmentType = models.ForeignKey(EquipmentType, on_delete=models.CASCADE)
    photo = models.ImageField(null=True, upload_to='equipment_photos/')
    description = models.CharField(max_length=50)

    def __str__(self):
        return self.description

    class Meta:
        db_table = 'equipments_equipment_details'

class AtmosphericDischargeEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

    class Meta:
        db_table = 'equipments_atmospheric_discharge_equipments'

class FireAlarmEquipment(models.Model):
   area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
   equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class SructeredCablingEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class DistributionBoardEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class ElectricalCircuitEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class ElectricalLineEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class ElectricalLoadEquipment(models.MOdel):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)

class IluminationEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
