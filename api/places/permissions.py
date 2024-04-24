from rest_framework import permissions

from places.models import Place

class IsPlaceOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.place_owner.user == request.user
