from .models import EquipmentDetail
from rest_framework import serializers

class ValidateAreaMixin:

    def validate(self, data):
        """
        Garante que o equipment detail pertence ao system.
        """
        equipment_detail = data.get('equipment_detail')
        if equipment_detail:
            equipment_type_system = equipment_detail.equipmentType.system
            if equipment_type_system != data['system']:
                raise serializers.ValidationError("The equipment type's system must match the equipment's system.")

        """
        Garante que o equipment detail pertence ao place owner.
        """
        user = self.context['request'].user
        if equipment_detail.place_owner != user.placeowner:
            raise serializers.ValidationError("You are not the owner of the equipment detail's place")
        return data

    def validate_area(self, value):
        """
        Garante que a area pertence ao place owner.
        """
        user = self.context['request'].user
        if value.place.place_owner != user.placeowner:
            raise serializers.ValidationError("You are not the owner of this place")
        return value