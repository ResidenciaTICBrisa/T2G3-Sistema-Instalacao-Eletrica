from rest_framework import permissions


class IsPlaceOwner(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.place_owner.user == request.user


class IsPlaceEditor(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.editors.filter(user=request.user).exists()
