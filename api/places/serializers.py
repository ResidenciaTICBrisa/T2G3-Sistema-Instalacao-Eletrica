from rest_framework import serializers
from .models import Places

class PlacesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Places
        fields = ['name', 'user']