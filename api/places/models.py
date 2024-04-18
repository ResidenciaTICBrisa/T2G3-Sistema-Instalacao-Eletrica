from django.db import models
from django.core.validators import MinValueValidator
from users.models import PlaceOwner
from django.contrib.auth.models import Permission, Group
from django.contrib.contenttypes.models import ContentType

class Place(models.Model):

    name = models.CharField(max_length=50)
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.name

class Room(models.Model):

    name = models.CharField(max_length=50)
    floor = models.IntegerField(default=0, validators=[MinValueValidator(0)])
<<<<<<< HEAD
    place = models.ForeignKey(Place, related_name='rooms', on_delete=models.CASCADE)
    systems = models.ManyToManyField('systems.System')

=======
    place = models.ForeignKey(Place, related_name='rooms', on_delete=models.DO_NOTHING)
    systems = models.ManyToManyField('systems.System')

    
>>>>>>> 460be61 (Backend: list places por placesowner)
