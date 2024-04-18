from rest_framework import viewsets, generics
from .models import System, EquipmentType
from .serializers import SystemSerializer, EquipmentTypeSerializer

class SystemViewList(generics.ListAPIView):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []

class SystemViewDetail(generics.RetrieveAPIView):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []

class EquipmentTypeList(generics.ListAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []

class EquipmentTypeDetail(generics.RetrieveAPIView):
    queryset = EquipmentType.objects.all()
    serializer_class = EquipmentTypeSerializer
    permission_classes = []


