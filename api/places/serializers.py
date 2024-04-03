from rest_framework import serializers
from .models import Place, Room

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['name', 'user']

class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = ['id', 'name', 'floor', 'systems', 'place']
        extra_kwargs = {
            'name': {'required': True},
            'floor': {'required': True},
            'place_id': {'read_only': True}
        }