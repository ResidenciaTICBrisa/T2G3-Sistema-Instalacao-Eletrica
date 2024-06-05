from django.db import models
from places.models import Area
from systems.models import System
from users.models import PlaceOwner

class PersonalEquipmentType(models.Model):

    name = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'equipments_personal_equipment_types'

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

    class Meta:
        db_table = 'equipments_equipment_details'

class EquipmentPhoto(models.Model):

    photo = models.ImageField(null=True, upload_to='equipment_photos/')
    description = models.CharField(max_length=50, null=True)
    equipmentType = models.ForeignKey(EquipmentType, on_delete=models.CASCADE, null=True)
    personalEquipmentType = models.ForeignKey(PersonalEquipmentType, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.description

class FireAlarmEquipment(models.Model):

   area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
   equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
   system = models.ForeignKey(System, on_delete=models.CASCADE, default=8)

   class Meta:
       db_table = 'equipments_fire_alarm_equipments'

class AtmosphericDischargeEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=7)

    class Meta:
        db_table = 'equipments_atmospheric_discharge_equipments'

class StructuredCablingEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=6)
    
    class Meta:
        db_table = 'equipments_structured_cabling_equipments'

class DistributionBoardEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=5)
    
    class Meta:
        db_table = 'equipments_distribution_board_equipments'

class ElectricalCircuitEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=4)
    
    class Meta:
        db_table = 'equipments_electrical_circuit_equipments'

class ElectricalLineEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=3)
    
    class Meta:
        db_table = 'equipments_electrical_line_equipments'

class ElectricalLoadEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=2)
    
    class Meta:
        db_table = 'equipments_electrical_load_equipments'

class IluminationEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=1)
 
    class Meta:
        db_table = 'equipments_ilumination_equipments'

class RefrigerationEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True)
    equipment_detail = models.OneToOneField(EquipmentDetail, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=2)
    
    class Meta:
        db_table = 'refrigeration_equipments'