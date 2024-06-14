from .models import Equipment, PersonalEquipmentCategory
from rest_framework import serializers
from django.core.exceptions import ObjectDoesNotExist

class ValidateAreaMixin:

    def validate_equipment(self, value):
        """
        Garante que o equipment pertence ao place owner.
        """
        user = self.context['request'].user
        if value.equipment.place_owner != user.place_owner:
            raise serializers.ValidationError("You are not the owner of the equipment")
        return value

    def validate_area(self, value):
        """
        Garante que a area pertence ao place owner.
        """
        user = self.context['request'].user
        if value.place.place_owner != user.place_owner:
            raise serializers.ValidationError("You are not the owner of this place")
        return value