from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from places.models import Area
from .models import  *
from .serializers import *
from .permissions import *
from rest_framework import status

class EquipmentTypeList(generics.ListAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = [IsAuthenticated]

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

class AtmosphericDischargeEquipmentList(generics.ListCreateAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return AtmosphericDischargeEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area and area.place.place_owner == request.user.placeowner:
            system_id = 8
            equipment_detail_id = request.data.get('equipment_detail')
            equipment_detail = EquipmentDetail.objects.filter(id=equipment_detail_id, equipmentType__system_id=system_id).first()

            if equipment_detail:
                serializer = self.get_serializer(data=request.data)
                serializer.is_valid(raise_exception=True)
                serializer.save()
                headers = self.get_success_headers(serializer.data)
                return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
            else:
                return Response({"message": "The equipment detail does not belong to the specified system"}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

class AtmosphericDischargeEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class FireAlarmEquipmentList(generics.ListCreateAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return FireAlarmEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()
     
        if area and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

class FireAlarmEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = FireAlarmEquipment.objects.all()
    serializer_class = FireAlarmEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class SructeredCablingEquipmentList(generics.ListCreateAPIView):
    queryset = SructeredCablingEquipment.objects.all()
    serializer_class = SructeredCablingEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return SructeredCablingEquipment.objects.filter(area__place__place_owner=user.placeowner)

    def create(self, request, *args, **kwargs):
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()
     
        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

class SructeredCablingEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = SructeredCablingEquipment.objects.all()
    serializer_class = SructeredCablingEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class DistributionBoardEquipmentList(generics.ListCreateAPIView):
    queryset = DistributionBoardEquipment.objects.all()
    serializer_class = DistributionBoardEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return DistributionBoardEquipment.objects.filter(area__place__place_owner=user.placeowner)
    
    def create(self, request, *args, **kwargs):
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

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
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

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
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)
    
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
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

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
        area_id = request.data.get('area')
        area = Area.objects.filter(id=area_id).first()

        if area is not None and area.place.place_owner == request.user.placeowner:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_200_OK, headers=headers)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

class IluminationEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = IluminationEquipment.objects.all()
    serializer_class = IluminationEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]




