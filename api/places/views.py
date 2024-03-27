from django.shortcuts import render

from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Place, Room
from .serializers import PlaceSerializer, RoomSerializer
from .permissions import IsOwnerOrReadOnly

class PlacesList(generics.ListCreateAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = []

class PlaceDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = []

class RoomsList(generics.ListCreateAPIView):
    queryset = Room.objects.all()
    serializer_class =  RoomSerializer
    permission_classes = [IsAuthenticated]

class RoomDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    permission_classes = [IsAuthenticated]