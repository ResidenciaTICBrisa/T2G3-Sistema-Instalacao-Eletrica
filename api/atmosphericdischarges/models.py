from django.db import models
from equipments.models import Equipment
from places.models import Place

class AtmosphericDischarge(models.Model):
    place = models.ForeignKey(Place, related_name='atmospheric_discharges', on_delete=models.CASCADE,null=True)
    equipment = models.ForeignKey(Equipment, related_name='atmospheric_discharges', on_delete=models.CASCADE)

    class Meta:
        db_table = 'atmospheric_discharges'



