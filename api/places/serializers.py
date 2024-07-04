from rest_framework import serializers

from .models import Place, Area


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
        fields = ['id', 'name', 'floor', 'place']
        extra_kwargs = {
            'name': {'required': True},
            'floor': {'required': True},
            'place': {'required': True}
        }
