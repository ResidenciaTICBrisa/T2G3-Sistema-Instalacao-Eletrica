from rest_framework.permissions import BasePermission

class IsPlaceOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.place_owner == request.user.place_owner:
            return True
        return False

class IsEquipmentOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.equipment.place.place_owner == request.user.place_owner:
            return True
        else:
            return False

class IsSpecificEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.area.place.editors.filter(user=request.user).exists()