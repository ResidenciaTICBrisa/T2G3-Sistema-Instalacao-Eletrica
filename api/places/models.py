from django.db import models
from django.core.validators import MinValueValidator
from users.models import PlaceOwner

class Place(models.Model):

    name = models.CharField(max_length=50)
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.name

class Area(models.Model):

    name = models.CharField(max_length=50)
    floor = models.IntegerField(default=0, validators=[MinValueValidator(0)])
    place = models.ForeignKey(Place, related_name='areas', on_delete=models.CASCADE, null=True)
    systems = models.ManyToManyField('systems.System')

    
