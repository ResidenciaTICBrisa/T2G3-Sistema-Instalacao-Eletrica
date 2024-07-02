from rest_framework import serializers


class ValidateAreaMixin:

    def validate_area(self, value):
        """
        Garante que a area pertence ao place owner ou ao editor.
        """
        user = self.context['request'].user
        if value.place.place_owner != user.place_owner and not value.place.editors.filter(user=user).exists():
            raise serializers.ValidationError("You are not the owner or editor of this place")
        return value


class EquipmentCategoryMixin:

    def get_equipment_category(self, obj):
        equipment = obj.equipment
        if equipment.generic_equipment_category is not None:
            return equipment.generic_equipment_category.name
        elif equipment.personal_equipment_category is not None:
            return equipment.personal_equipment_category.name
        return None
