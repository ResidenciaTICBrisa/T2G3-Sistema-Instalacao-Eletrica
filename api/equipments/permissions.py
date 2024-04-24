from rest_framework.permissions import BasePermission

class OwnerEquip(BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.placeowner == obj.placeOwner:
            return True
        else:
            return False

class AtmosphericDischargeEquipmentOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.placeowner == obj.area.place.place_owner:
            return True
        else:
           return False
