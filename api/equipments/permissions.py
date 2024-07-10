from rest_framework.permissions import BasePermission
from .models import *

system = [IluminationEquipment, ElectricalLoadEquipment,  ElectricalLineEquipment, ElectricalCircuitEquipment, DistributionBoardEquipment, StructuredCablingEquipment, AtmosphericDischargeEquipment, FireAlarmEquipment, RefrigerationEquipment]

from users.models import PlaceOwner


def get_place_owner_or_create(user):
    try:
        return user.place_owner
    except PlaceOwner.DoesNotExist:
        return PlaceOwner.objects.create(user=user)


class IsOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        for equipment in system:
            equipment_obj = getattr(obj, equipment.__name__.lower(), None)
            if equipment_obj and equipment_obj.area.place.place_owner:
                return equipment_obj.area.place.place_owner == request.user.place_owner
        return False


class IsPlaceOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.place_owner == request.user.place_owner:
            return True
        return False


class IsEquipmentPhotoOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.equipment:
            for equipment in system:
                equipment_obj = getattr(obj.equipment, equipment.__name__.lower(), None)
                if equipment_obj and equipment_obj.place_owner:
                    if equipment_obj.place_owner == request.user.place_owner:
                        return True
        return False


class IsEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        for equipment in system:
            equipment_obj = getattr(obj, equipment.__name__.lower(), None)
            if equipment_obj and equipment_obj.area.place.editors.filter(user=request.user).exists():
                return True
        return False

class IsEquipmentEditorPhoto(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.equipment:
            for equipment in system:
                equipment_obj = getattr(obj.equipment, equipment.__name__.lower(), None)
                if equipment_obj and equipment_obj.area.place.editors.filter(user=request.user).exists():
                    return True


class IsSpecificEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.area and obj.area.place:
            return obj.area.place.editors.filter(user=request.user).exists()
        return False
