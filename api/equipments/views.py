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
    permission_classes = [IsOwner, IsAuthenticated]

    def create(self, request, *args, **kwargs):

        if(IsOwner):
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
    permission_classes = [IsOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        queryset = super().get_queryset()
        return queryset.filter(place_owner__user=user)

    def create(self, request, *args, **kwargs):

        if(IsOwner):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save(place_owner=request.user.placeowner)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class EquipmentDetailDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = EquipmentDetail.objects.all()
    serializer_class = EquipmentDetailSerializer
    permission_classes = [IsOwner, IsAuthenticated]

class EquipmentPhotoList(generics.ListCreateAPIView):
    queryset = EquipmentPhoto.objects.all()
    serializer_class = EquipmentPhotoSerializer
    permission_classes = [IsEquipmentDetailOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        queryset = super().get_queryset()
        return queryset.filter(equipment_detail__place_owner__user=user)

class EquipmentPhotoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = EquipmentPhoto.objects.all()
    serializer_class = EquipmentPhotoSerializer
    permission_classes = [IsEquipmentDetailOwner, IsAuthenticated]

class RefrigerationEquipmentList(generics.ListCreateAPIView):
    queryset = RefrigerationEquipment.objects.all()
    serializer_class = RefrigerationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return RefrigerationEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        data = request.data.copy() 
        data["system"] = 9
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
    
class RefrigerationEquipmentByAreaList(generics.ListAPIView):
    serializer_class = RefrigerationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return RefrigerationEquipment.objects.filter(area_id=area_id)

class RefrigerationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = RefrigerationEquipment.objects.all()
    serializer_class = RefrigerationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

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

class FireAlarmEquipmentByAreaList(generics.ListAPIView):
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return FireAlarmEquipment.objects.filter(area_id=area_id)

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

class AtmosphericDischargeEquipmentByAreaList(generics.ListAPIView):
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return AtmosphericDischargeEquipment.objects.filter(area_id=area_id)

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

class StructuredCablingEquipmentByAreaList(generics.ListAPIView):
    serializer_class = StructuredCablingEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return StructuredCablingEquipment.objects.filter(area_id=area_id)

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

class DistributionBoardEquipmentByAreaList(generics.ListAPIView):
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return DistributionBoardEquipment.objects.filter(area_id=area_id)

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

class ElectricalCircuitEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalCircuitEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return ElectricalCircuitEquipment.objects.filter(area_id=area_id)

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
    
class ElectricalLineEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalLineEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return ElectricalLineEquipment.objects.filter(area_id=area_id)
    
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

class ElectricalLoadEquipmentByAreaList(generics.ListAPIView):
    serializer_class = ElectricalLoadEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return ElectricalLoadEquipment.objects.filter(area_id=area_id)

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

class IluminationEquipmentByAreaList(generics.ListAPIView):
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        area_id = self.kwargs['area_id']
        return IluminationEquipment.objects.filter(area_id=area_id)

class IluminationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]