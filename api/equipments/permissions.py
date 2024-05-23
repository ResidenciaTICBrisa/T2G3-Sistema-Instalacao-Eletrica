from rest_framework.permissions import BasePermission

from places.models import Area

class IsOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.place_owner == request.user.placeowner:
            return True
        else:
            return False

class IsEquipmentDetailOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.equipment_detail.place_owner == request.user.placeowner:
            return True
        else:
            return False

class IsPlaceOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.area.place.place_owner == request.user.placeowner:
            return True
        return False

