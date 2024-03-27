from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Places(models.Model):

    name = models.CharField(max_length=50)
    user = models.ForeignKey(User, verbose_name=("donos"), on_delete=models.CASCADE)
