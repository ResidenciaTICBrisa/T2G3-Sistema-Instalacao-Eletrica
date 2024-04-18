from django.db import models
from places.models import Place, Room

class System(models.Model):

    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name
class EquipmentType(models.Model):
    type = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)



class EquipmentPhoto(models.Model):
    photo = models.ImageField(null=True, upload_to='equipment_photos/')
    description = models.CharField(max_length=50)

class Equipment(models.Model):
    equipmentType = models.ForeignKey(EquipmentType, on_delete=models.CASCADE)
    equipmentPhoto = models.ForeignKey(EquipmentPhoto, on_delete=models.CASCADE, null=True)

    

class AtmosphericDischargeSystem(models.Model):
    place = models.ForeignKey(Place, related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)
    room = models.ForeignKey(Room, related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)
    system = models.ForeignKey('systems.System', related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)

    class Meta:
        db_table = 'atmospheric_discharge_systems'
