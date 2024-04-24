from django.db import models
from places.models import Room
from systems.models import System
from users.models import PlaceOwner

class EquipmentType(models.Model):
    type = models.CharField(max_length=50)
    system = models.ForeignKey(System, on_delete=models.CASCADE)
    def __str__(self):
        return self.type

class Equipment(models.Model):
    placeOwner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)
    equipmentType = models.ForeignKey(EquipmentType, on_delete=models.CASCADE)
    photo = models.ImageField(null=True, upload_to='equipment_photos/')
    description = models.CharField(max_length=50)

#Corrige este model
class AtmosphericDischargeEquipment(models.Model):
    equipment = models.OneToOneField(Equipment, on_delete=models.CASCADE, null=True)
    room = models.ForeignKey(Room, on_delete=models.CASCADE, null=True)
