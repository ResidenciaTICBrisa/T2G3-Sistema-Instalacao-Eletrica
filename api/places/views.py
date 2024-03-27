from django.shortcuts import render
from rest_framework import generics
from .models import Places
from .serializers import PlacesSerializer
# Create your views here.

class PlacesList(generics.ListCreateAPIView):
    queryset = Places.objects.all()
    serializer_class = PlacesSerializer
    permission_classes = []



