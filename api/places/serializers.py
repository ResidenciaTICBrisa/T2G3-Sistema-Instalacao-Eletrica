from rest_framework import serializers
from .models import Place, Room

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['name', 'user']

class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = ['name']