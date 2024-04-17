from django.db import models
from places.models import Place, Room

class System(models.Model):

    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name

class AtmosphericDischargeSystem(models.Model):
    place = models.ForeignKey(Place, related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)
    room = models.ForeignKey(Room, related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)
    system = models.ForeignKey('systems.System', related_name='atmospheric_discharge_systems', on_delete=models.CASCADE)

    class Meta:
        db_table = 'atmospheric_discharge_systems'
