from django.db import models
from places.models import Place, Area
from systems.models import System
from users.models import PlaceOwner


class PersonalEquipmentCategory(models.Model):
    name = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'personal_equipment_categories'


class GenericEquipmentCategory(models.Model):
    name = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'generic_equipment_categories'


class Equipment(models.Model):
    generic_equipment_category = models.ForeignKey(GenericEquipmentCategory, on_delete=models.CASCADE, null=True)
    personal_equipment_category = models.ForeignKey(PersonalEquipmentCategory, on_delete=models.CASCADE, null=True)

    def __str__(self):
        if self.generic_equipment_category is not None:
            return str(self.generic_equipment_category.name)
        elif self.personal_equipment_category is not None:
            return str(self.personal_equipment_category.name)
        return 'No category'

    class Meta:
        db_table = 'equipments'


class EquipmentPhoto(models.Model):
    photo = models.ImageField(null=True, upload_to='equipment_photos/')
    description = models.CharField(max_length=50, null=True)
    equipment = models.ForeignKey(Equipment, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.description

    class Meta:
        db_table = 'equipments_photos'


class IluminationEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="ilumination_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=1)



    class Meta:
        db_table = 'equipments_illuminations'


class ElectricalLoadEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="electrical_load_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=2)
    brand = models.CharField(max_length=30, default=None)
    model = models.CharField(max_length=50, default=None)
    power = models.IntegerField(default=0)
    quantity = models.IntegerField(default=0)


    class Meta:
        db_table = 'equipments_electrical_loads'


class ElectricalLineEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="electrical_line_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=3)

    class Meta:
        db_table = 'equipments_electrical_lines'


class ElectricalCircuitEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name='electrical_circuit_equipment')
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=4)
    size = models.IntegerField(default=0)
    isolament = models.CharField(max_length=30, default=None)

    class Meta:
        db_table = 'equipments_electrical_circuits'


class DistributionBoardEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="distribution_board_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=5)
    power = models.IntegerField(default=0)
    dr = models.BooleanField(default=False)
    dps = models.BooleanField(default=False)
    grounding = models.BooleanField(default=False)
    type_material = models.CharField(max_length=30, null=True)
    method_installation = models.CharField(max_length=50, null=True)


    class Meta:
        db_table = 'equipments_distribution_boards'


class StructuredCablingEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="structured_cabling_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=6)

    class Meta:
        db_table = 'equipments_structured_cabling'


class AtmosphericDischargeEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="atmospheric_discharge_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=7)

    class Meta:
        db_table = 'equipments_atmospheric_discharges'


class FireAlarmEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="fire_alarm_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True, related_name="fire_alarm")
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=8)

    class Meta:
        db_table = 'equipments_fire_alarms'


class RefrigerationEquipment(models.Model):
    area = models.ForeignKey(Area, on_delete=models.CASCADE, null=True, related_name="refrigeration_equipment")
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    system = models.ForeignKey(System, on_delete=models.CASCADE, default=9)
    power = models.IntegerField(default=0)
    quantity = models.IntegerField(default=0)

    class Meta:
        db_table = 'equipments_refrigeration'
