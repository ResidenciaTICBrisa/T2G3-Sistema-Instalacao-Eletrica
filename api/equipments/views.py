from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .models import  EquipmentType, EquipmentDetail, AtmosphericDischargeEquipment
from .serializers import EquipmentTypeSerializer, EquipmentDetailSerializer, AtmosphericDischargeEquipmentSerializer
from .permissions import OwnerEquip, IsPlaceOwner
from rest_framework import status

class EquipmentTypeList(generics.ListAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []

class EquipmentTypeDetail(generics.RetrieveAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []

class EquipmentDetailList(generics.ListCreateAPIView):
    queryset = EquipmentDetail.objects.all()
    serializer_class = EquipmentDetailSerializer
    permission_classes = [OwnerEquip]

    def create(self, request, *args, **kwargs):

        if(OwnerEquip):
          serializer = self.get_serializer(data=request.data)
          serializer.is_valid(raise_exception=True)
          serializer.save(placeOwner=request.user.placeowner)
          headers = self.get_success_headers(serializer.data)
          return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class EquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = EquipmentDetail.objects.all()
    serializer_class = EquipmentDetailSerializer
    permission_classes = [OwnerEquip]

class AtmosphericDischargeEquipmentList(generics.ListCreateAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]

class AtmosphericDischargeEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]