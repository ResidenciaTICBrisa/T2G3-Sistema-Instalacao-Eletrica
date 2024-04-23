from django.db import models
from places.models import Place

class AtmosphericDischarge(models.Model):
    place = models.OneToOneField(Place, related_name='atmospheric_discharges', on_delete=models.CASCADE,null=True)
    

    class Meta:
        db_table = 'atmospheric_discharges'



