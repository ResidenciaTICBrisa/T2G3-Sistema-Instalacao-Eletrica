from rest_framework import generics


class PermissionFilteredListView(generics.ListAPIView):
    """
    Classe base para ListAPIView que filtra o queryset baseado nas permissões do usuário.
    """

    def get_queryset(self):
        queryset = super().get_queryset()

        user = self.request.user
        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):
        """
        Verifica as permissões de objeto para cada item no queryset.
        """
        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True
