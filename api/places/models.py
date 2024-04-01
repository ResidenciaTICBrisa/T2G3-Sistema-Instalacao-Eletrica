from django.db import models
from django.core.validators import MinValueValidator
from django.contrib.auth.models import User

class Place(models.Model):

    name = models.CharField(max_length=50)
    user = models.ForeignKey(User, verbose_name=("creator"), on_delete=models.CASCADE)

class Room(models.Model):

    name = models.CharField(max_length=50)
    floor = models.IntegerField(default=0, validators=[MinValueValidator(0)])
    place = models.ForeignKey(Place, related_name='rooms', on_delete=models.CASCADE)
    systems = models.ManyToManyField('systems.System')




