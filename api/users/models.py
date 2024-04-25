from django.db import models
from django.contrib.auth.models import User

class PlaceOwner(models.Model):

    user = models.OneToOneField(User, verbose_name=("user"), on_delete=models.CASCADE, related_name='placeowner')

    def __str__(self):
        return self.user.first_name