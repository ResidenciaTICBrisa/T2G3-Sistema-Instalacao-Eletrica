from rest_framework import permissions

from places.models import Place

class IsPlaceOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.place.place_owner.user == request.user

class IsPlaceOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        place_owner = obj.place_owner
        return place_owner.user == request.user

