from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from places.models import Area
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

    def get_queryset(self):
        user = self.request.user
        return AtmosphericDischargeEquipment.objects.filter(area__place__place_owner=user.placeowner)

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

class AtmosphericDischargeEquipmentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = AtmosphericDischargeEquipment.objects.all()
    serializer_class = AtmosphericDischargeEquipmentSerializer
    permission_classes = [IsPlaceOwner, IsAuthenticated]