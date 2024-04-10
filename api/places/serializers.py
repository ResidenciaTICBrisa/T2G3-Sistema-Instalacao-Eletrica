from rest_framework import serializers
from .models import Place, Room

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['name', 'place_owner']
        extra_kwargs = {
            'name': {'required': True},
            'place_owner': {'read_only': True}
        }

class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = ['id', 'name', 'floor', 'systems', 'place']
        extra_kwargs = {
            'name': {'required': True},
            'floor': {'required': True},
            'place_id': {'read_only': True}
        }