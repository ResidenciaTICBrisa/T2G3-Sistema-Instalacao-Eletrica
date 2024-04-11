from rest_framework import serializers
from .models import Place, Room
from users.serializers import PlaceOwnerSerializer

class PlaceSerializer(serializers.ModelSerializer):

    class Meta:
        model = Place
        fields = ['id', 'name', 'place_owner']
        extra_kwargs = {
            'name': {'required': True}
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