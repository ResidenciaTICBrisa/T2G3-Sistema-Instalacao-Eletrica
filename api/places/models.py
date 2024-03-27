from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class PlacesModel(models.Model):

    name = models.CharField(max_length=50)
    user = models.ForeignKey(User, verbose_name=("places"), on_delete=models.CASCADE)
