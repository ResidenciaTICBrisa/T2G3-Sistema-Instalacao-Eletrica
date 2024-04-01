from django.shortcuts import render

from rest_framework import viewsets

from .models import System
from .serializers import SystemSerializer

class SystemViewSet(viewsets.ModelViewSet):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []