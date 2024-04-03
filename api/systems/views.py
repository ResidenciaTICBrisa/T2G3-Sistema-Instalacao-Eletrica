from rest_framework import viewsets, generics
from .models import System
from .serializers import SystemSerializer

class SystemViewList(generics.ListAPIView):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []

class SystemViewDetail(generics.RetrieveAPIView):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []