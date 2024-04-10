from django.db import models
from django.contrib.auth.models import User

class PlaceOwner(models.Model):

    user = models.OneToOneField(User, verbose_name=("user"), on_delete=models.DO_NOTHING)
    