from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .permissions import *
from .serializers import *


def get_place_owner_or_create(user):
    try:
        return user.place_owner
    except PlaceOwner.DoesNotExist:
        return PlaceOwner.objects.create(user=user)


class PersonalEquipmentCategoryCreate(generics.CreateAPIView):
    queryset = PersonalEquipmentCategory.objects.all()
    serializer_class = PersonalEquipmentCategorySerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        user = request.user
        place_owner = get_place_owner_or_create(user)
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(place_owner=place_owner)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class PersonalEquipmentCategoryList(generics.ListAPIView):
    queryset = PersonalEquipmentCategory.objects.all()
    serializer_class = PersonalEquipmentCategorySerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        system_id = self.kwargs['system_id']
        return PersonalEquipmentCategory.objects.filter(system_id=system_id)


class PersonalEquipmentCategoryDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PersonalEquipmentCategory.objects.all()
    serializer_class = PersonalEquipmentCategorySerializer
    permission_classes = [IsAuthenticated]


class GenericEquipmentCategoryList(generics.ListAPIView):
    queryset = GenericEquipmentCategory.objects.all()
    serializer_class = GenericEquipmentCategorySerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        system_id = self.kwargs['system_id']
        return GenericEquipmentCategory.objects.filter(system_id=system_id)


class GenericEquipmentCategoryDetail(generics.RetrieveAPIView):
    queryset = GenericEquipmentCategory.objects.all()
    serializer_class = GenericEquipmentCategorySerializer
    permission_classes = [IsAuthenticated]


class EquipmentList(generics.ListAPIView):
    queryset = Equipment.objects.all()
    serializer_class = EquipmentSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        queryset = super().get_queryset()
        return queryset.filter(place_owner__user=user)


class EquipmentCreate(generics.CreateAPIView):
    queryset = Equipment.objects.all()
    serializer_class = EquipmentSerializer
    permission_classes = [IsAuthenticated]

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context.update({
            'request': self.request
        })
        return context


class EquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Equipment.objects.all()
    serializer_class = EquipmentSerializer
    permission_classes = [IsAuthenticated]


class EquipmentPhotoList(generics.ListCreateAPIView):
    queryset = EquipmentPhoto.objects.all()
    serializer_class = EquipmentPhotoSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner]

    def get_queryset(self):
        user = self.request.user
        queryset = super().get_queryset()
        return queryset.filter(equipment__place_owner__user=user)


class EquipmentPhotoByEquipmentList(generics.ListAPIView):
    serializer_class = EquipmentPhotoSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner]

    def get_queryset(self):
        equipment_id = self.kwargs['equipment_id']
        user = self.request.user
        return EquipmentPhoto.objects.filter(equipment_id=equipment_id, equipment__place_owner__user=user)


class EquipmentPhotoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = EquipmentPhoto.objects.all()
    serializer_class = EquipmentPhotoSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner]


class RefrigerationEquipmentList(generics.ListCreateAPIView):
    queryset = RefrigerationEquipment.objects.all()
    serializer_class = RefrigerationEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner, IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return RefrigerationEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 9
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class RefrigerationEquipmentByAreaList(generics.ListAPIView):
    serializer_class = RefrigerationEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = RefrigerationEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class RefrigerationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = RefrigerationEquipment.objects.all()
    serializer_class = RefrigerationEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class FireAlarmEquipmentList(generics.ListCreateAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return FireAlarmEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 8
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class FireAlarmEquipmentByAreaList(generics.ListAPIView):
    serializer_class = FireAlarmEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = FireAlarmEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class FireAlarmEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class AtmosphericDischargeEquipmentList(generics.ListCreateAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return AtmosphericDischargeEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 7
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class AtmosphericDischargeEquipmentByAreaList(generics.ListAPIView):
    serializer_class = AtmosphericDischargeEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner, IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = AtmosphericDischargeEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True

class AtmosphericDischargeEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class StructuredCablingEquipmentList(generics.ListCreateAPIView):
    queryset = StructuredCablingEquipment.objects.all()
    serializer_class = StructuredCablingEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return StructuredCablingEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 6
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class StructuredCablingEquipmentByAreaList(generics.ListAPIView):
    serializer_class = StructuredCablingEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = StructuredCablingEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True

class StructuredCablingEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = StructuredCablingEquipment.objects.all()
    serializer_class = StructuredCablingEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class DistributionBoardEquipmentList(generics.ListCreateAPIView):
    queryset = DistributionBoardEquipment.objects.all()
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return DistributionBoardEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 5
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class DistributionBoardEquipmentByAreaList(generics.ListAPIView):
    serializer_class = DistributionBoardEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = DistributionBoardEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class DistributionBoardEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DistributionBoardEquipment.objects.all()
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class ElectricalCircuitEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalCircuitEquipment.objects.all()
    serializer_class = ElectricalCircuitEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return ElectricalCircuitEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 4
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class ElectricalCircuitEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalCircuitEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = ElectricalCircuitEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True

class ElectricalCircuitEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalCircuitEquipment.objects.all()
    serializer_class = ElectricalCircuitEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class ElectricalLineEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalLineEquipment.objects.all()
    serializer_class = ElectricalLineEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return ElectricalLineEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 3
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class ElectricalLineEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalLineEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = ElectricalLineEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class ElectricalLineEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalLineEquipment.objects.all()
    serializer_class = ElectricalLineEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class ElectricalLoadEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalLoadEquipment.objects.all()
    serializer_class = ElectricalLoadEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return ElectricalLoadEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 2
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class ElectricalLoadEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalLoadEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = ElectricalLoadEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class ElectricalLoadEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalLoadEquipment.objects.all()
    serializer_class = ElectricalLoadEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]


class IluminationEquipmentList(generics.ListCreateAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        user = self.request.user
        place_owner = get_place_owner_or_create(user)
        return IluminationEquipment.objects.filter(area__place__place_owner=place_owner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        data["system"] = 1
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)


class IluminationEquipmentByAreaList(generics.ListAPIView):
    serializer_class = IluminationEquipmentResponseSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        queryset = IluminationEquipment.objects.filter(area_id=area_id)

        permitted_objects = []
        for obj in queryset:
            if self.check_object_permissions(self.request, obj):
                permitted_objects.append(obj.id)

        return queryset.filter(id__in=permitted_objects)

    def check_object_permissions(self, request, obj):

        for permission in self.get_permissions():
            if not permission.has_object_permission(request, self, obj):
                return False
        return True


class IluminationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsAuthenticated, IsEquipmentOwner | IsSpecificEquipmentEditor]
