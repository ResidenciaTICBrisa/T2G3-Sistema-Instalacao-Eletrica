from rest_framework.permissions import BasePermission

from users.models import PlaceOwner


def get_place_owner_or_create(user):
    try:
        return user.place_owner
    except PlaceOwner.DoesNotExist:
        return PlaceOwner.objects.create(user=user)


class IsOwner(BasePermission):
    def has_object_permission(self, request, view, obj):
        get_place_owner_or_create(request.user)
        return obj.place_owner == request.user.place_owner


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


class IsEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.place_owner.places.editors.filter(user=request.user).exists()


class IsEquipmentEditorPhoto(BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.equipment.place_owner.places.editors.filter(user=request.user).exists()


class IsSpecificEquipmentEditor(BasePermission):
    def has_object_permission(self, request, view, obj):
        if obj.area and obj.area.place:
            return obj.area.place.editors.filter(user=request.user).exists()
        return False
