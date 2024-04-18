from rest_framework.permissions import BasePermission

class OwnerEquip(BasePermission):
    def has_object_permission(self, request, view, obj):
        if(request.user.placeowner == obj.placeOwner):
            return True
        else:
            return False