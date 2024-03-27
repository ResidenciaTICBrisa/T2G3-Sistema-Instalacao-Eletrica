from django.shortcuts import render

from rest_framework import generics
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets, mixins
from rest_framework.decorators import action
from rest_framework.response import Response

from .models import Place, Room
from .serializers import PlaceSerializer, RoomSerializer
from .permissions import IsOwnerOrReadOnly

class PlaceViewSet(viewsets.ModelViewSet):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = [IsAuthenticated]

    @action(detail=True, methods=['get'])
    def rooms(self, request, pk=None):
        place = self.get_object()
        serializer = RoomSerializer(place.rooms.all(), many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'], url_path='rooms/(?P<room_pk>\d+)')
    def room(self, request, pk=None, room_pk=None):
        place = self.get_object()
        room = get_object_or_404(place.rooms.all(), pk=room_pk)
        serializer = RoomSerializer(room)
        return Response(serializer.data)

class RoomViewSet(viewsets.ModelViewSet):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
    permission_classes = [IsAuthenticated]