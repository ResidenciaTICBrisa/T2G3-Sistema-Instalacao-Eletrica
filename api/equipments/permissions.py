from rest_framework.permissions import BasePermission

from places.models import Area

class OwnerEquip(BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.placeowner == obj.placeOwner:
            return True
        else:
            return False

class IsPlaceOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.area.place.place_owner == request.user.placeowner:
            return True
        return False

