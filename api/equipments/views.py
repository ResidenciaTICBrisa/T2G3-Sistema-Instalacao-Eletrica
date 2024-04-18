from django.shortcuts import render
from rest_framework import viewsets, generics
from rest_framework.response import Response
from .models import  EquipmentType, Equipment
from .serializers import EquipmentTypeSerializer, EquipmentSerializer
from .permissions import OwnerEquip
from rest_framework import viewsets, status

class EquipmentTypeList(generics.ListAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []

class EquipmentTypeDetail(generics.RetrieveAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []

class EquipmentList(generics.ListCreateAPIView):
    queryset = Equipment.objects.all()
    serializer_class = EquipmentSerializer
    permission_classes = [OwnerEquip]

    def create(self, request, *args, **kwargs):
        
        if(OwnerEquip):
          serializer = self.get_serializer(data=request.data)
          serializer.is_valid(raise_exception=True)
          serializer.save(placeOwner=request.user.placeowner)
          headers = self.get_success_headers(serializer.data)
          return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
        

class EquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Equipment.objects.all()
    serializer_class = EquipmentSerializer
    permission_classes = [OwnerEquip]