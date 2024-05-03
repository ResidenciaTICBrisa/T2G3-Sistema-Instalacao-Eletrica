from .models import EquipmentDetail
from rest_framework import serializers

class ValidateEquipmentDetailAndAreaMixin:

    def validate_equipment_detail(self, value):
        """
        Garante que o equipment detail pertence ao system.
        """
        system_id = self.instance.system_id if self.instance else 7
        equipment_detail_id = value.id
        equipment_detail = EquipmentDetail.objects.filter(id=equipment_detail_id, equipmentType__system_id=system_id).first()

        if not equipment_detail:
            raise serializers.ValidationError("The equipment detail does not belong to the specified system")

        """
        Garante que o equipment detail pertence ao place owner.
        """
        user = self.context['request'].user
        if equipment_detail.place_owner != user.placeowner:
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