from django.db import models
from places.models import Place, Room

class System(models.Model):

    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name