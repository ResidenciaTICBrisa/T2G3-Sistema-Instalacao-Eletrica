from rest_framework.permissions import BasePermission


class IsOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.place_owner.user == request.user.place_owner


class IsPlaceOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.place_owner == request.user.place_owner:
            return True
        return False


class IsEquipmentOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.equipment and obj.equipment.place_owner:
            return obj.equipment.place_owner == request.user.place_owner
        return False


class IsSpecificEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.area and obj.area.place:
            return obj.area.place.editors.filter(user=request.user).exists()
        return False
