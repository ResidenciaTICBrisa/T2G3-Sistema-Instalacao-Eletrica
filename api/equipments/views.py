from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from places.models import Area
from .models import  *
from .serializers import *
from .permissions import *
from rest_framework import status

class PersonalEquipmentTypeCreate(generics.CreateAPIView):
    queryset = PersonalEquipmentType.objects.all()
    serializer_class = PersonalEquipmentTypeSerializer
    permission_classes = [IsEquipmentTypeOwner, IsAuthenticated]

    def create(self, request, *args, **kwargs):

        if(IsEquipmentTypeOwner):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(place_owner=request.user.placeowner)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class PersonalEquipmentTypeList(generics.ListAPIView):
    queryset = PersonalEquipmentType.objects.all()
    serializer_class = PersonalEquipmentTypeSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        system_id = self.kwargs['system_id']
        return PersonalEquipmentType.objects.filter(system_id=system_id)

class PersonalEquipmentTypeDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PersonalEquipmentType.objects.all()
    serializer_class = PersonalEquipmentTypeSerializer
    permission_classes = [IsAuthenticated]

class EquipmentTypeList(generics.ListAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        system_id = self.kwargs['system_id']
        return EquipmentType.objects.filter(system_id=system_id)

class EquipmentTypeDetail(generics.RetrieveAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = [IsAuthenticated]

class EquipmentDetailList(generics.ListCreateAPIView):
    queryset = EquipmentDetail.objects.all()
    serializer_class = EquipmentDetailSerializer
    permission_classes = [IsEquipmentDetailOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        queryset = super().get_queryset()
        return queryset.filter(place_owner__user=user)

    def create(self, request, *args, **kwargs):

        if(IsEquipmentDetailOwner):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(place_owner=request.user.placeowner)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class EquipmentDetailDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = EquipmentDetail.objects.all()
    serializer_class = EquipmentDetailSerializer
    permission_classes = [IsEquipmentDetailOwner, IsAuthenticated]

class FireAlarmEquipmentList(generics.ListCreateAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return FireAlarmEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 8
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class FireAlarmEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class AtmosphericDischargeEquipmentList(generics.ListCreateAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return AtmosphericDischargeEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 7
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class AtmosphericDischargeEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class StructuredCablingEquipmentList(generics.ListCreateAPIView):
    queryset = StructuredCablingEquipment.objects.all()
    serializer_class = StructuredCablingEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return StructuredCablingEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 6
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class StructuredCablingEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = StructuredCablingEquipment.objects.all()
    serializer_class = StructuredCablingEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class DistributionBoardEquipmentList(generics.ListCreateAPIView):
    queryset = DistributionBoardEquipment.objects.all()
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return DistributionBoardEquipment.objects.filter(area__place__place_owner=user.placeowner)
    
    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 5
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class DistributionBoardEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DistributionBoardEquipment.objects.all()
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class ElectricalCircuitEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalCircuitEquipment.objects.all()
    serializer_class = ElectricalCircuitEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return ElectricalCircuitEquipment.objects.filter(area__place__place_owner=user.placeowner)
    
    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 4
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class ElectricalCircuitEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalCircuitEquipment.objects.all()
    serializer_class = ElectricalCircuitEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class ElectricalLineEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalLineEquipment.objects.all()
    serializer_class = ElectricalLineEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return ElectricalLineEquipment.objects.filter(area__place__place_owner=user.placeowner)
    
    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 3
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
    
class ElectricalLineEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalLineEquipment.objects.all()
    serializer_class = ElectricalLineEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class ElectricalLoadEquipmentList(generics.ListCreateAPIView):
    queryset = ElectricalLoadEquipment.objects.all()
    serializer_class = ElectricalLoadEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return ElectricalLoadEquipment.objects.filter(area__place__place_owner=user.placeowner)
    
    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 2
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class ElectricalLoadEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ElectricalLoadEquipment.objects.all()
    serializer_class = ElectricalLoadEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class IluminationEquipmentList(generics.ListCreateAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return IluminationEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 1
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)

class IluminationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]