from .models import Equipment, PersonalEquipmentCategory
from rest_framework import serializers
from django.core.exceptions import ObjectDoesNotExist
from .permissions import *

class ValidateAreaMixin:

    def validate_area(self, value):
        """
        Garante que a area pertence ao place owner ou ao editor.
        """
        user = self.context['request'].user
        if value.place.place_owner != user.place_owner or not value.area.place.editors.filter(user=user).exists():
            raise serializers.ValidationError("You are not the owner or editor of this place")
        return value