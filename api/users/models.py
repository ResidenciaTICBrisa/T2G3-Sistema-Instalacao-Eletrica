from django.db import models
from django.contrib.auth.models import User

class PlaceOwner(models.Model):

    user = models.OneToOneField(User, verbose_name=("user"), on_delete=models.CASCADE, related_name='place_owner')

    def __str__(self):
        return self.user.first_name

class PlaceEditor(models.Model):

    user = models.OneToOneField(User, verbose_name=("user"), on_delete=models.CASCADE, related_name='place_editor')

    def __str__(self):
        return self.user.first_name
