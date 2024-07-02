from django.db import models

from users.models import PlaceOwner, PlaceEditor


class Place(models.Model):
    name = models.CharField(max_length=50)
    place_owner = models.ForeignKey(PlaceOwner, on_delete=models.CASCADE, null=True)
    lon = models.FloatField(null=True)
    lat = models.FloatField(null=True)
    photo = models.ImageField(null=True, upload_to='place_photos/')
    editors = models.ManyToManyField(PlaceEditor, related_name='places')

    def __str__(self):
        return self.name


class Area(models.Model):
    name = models.CharField(max_length=50)
    floor = models.IntegerField(default=0)
    place = models.ForeignKey(Place, on_delete=models.CASCADE, null=True, related_name='areas')

    def __str__(self):
        return self.name
