from rest_framework import serializers
from .models import Place, Area
from users.serializers import PlaceOwnerSerializer

class PlaceSerializer(serializers.ModelSerializer):

    class Meta:
        model = Place
        fields = ['id', 'name', 'place_owner', 'lon', 'lat']
        extra_kwargs = {
            'name': {'required': True}
        }

class AreaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Area
        fields = ['id', 'name', 'floor', 'systems', 'place']
        extra_kwargs = {
            'name': {'required': True},
            'floor': {'required': True},
            'place_id': {'read_only': True}
        }