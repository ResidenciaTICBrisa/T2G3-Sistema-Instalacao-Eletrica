from .models import EquipmentDetail, EquipmentType
from rest_framework import serializers
from django.core.exceptions import ObjectDoesNotExist

class ValidateAreaMixin:

    def validate_equipment_detail(self, value):
        """
        Garante que o equipment detail pertence ao place owner.
        """
        user = self.context['request'].user
        if value.equipment_detail.place_owner != user.placeowner:
            raise serializers.ValidationError("You are not the owner of the equipment detail's place")
        return value

    def validate_area(self, value):
        """
        Garante que a area pertence ao place owner.
        """
        user = self.context['request'].user
        if value.place.place_owner != user.placeowner:
            raise serializers.ValidationError("You are not the owner of this place")
        return value
