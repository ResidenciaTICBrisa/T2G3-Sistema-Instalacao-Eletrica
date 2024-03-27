from django.db import models
from django.contrib.auth.models import User

class Place(models.Model):

    name = models.CharField(max_length=50)
    user = models.ForeignKey(User, verbose_name=("creator"), on_delete=models.CASCADE)
