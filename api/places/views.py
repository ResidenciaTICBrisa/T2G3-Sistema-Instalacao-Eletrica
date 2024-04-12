from django.shortcuts import render

from users.models import PlaceOwner
from rest_framework import generics
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response

from .models import Place, Room
from .serializers import PlaceSerializer, RoomSerializer
from .permissions import IsOwnerOrReadOnly

class PlaceViewSet(viewsets.ModelViewSet):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        user = request.user

        try:
            place_owner = user.placeowner
        except PlaceOwner.DoesNotExist:
            place_owner = PlaceOwner.objects.create(user=user)

        place_data = request.data.copy()
        place_data['place_owner'] = place_owner.id
        place_serializer = self.get_serializer(data=place_data)
        place_serializer.is_valid(raise_exception=True)
        self.perform_create(place_serializer)

        headers = self.get_success_headers(place_serializer.data)
        return Response(place_serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        user = request.user
        place_owner = user.placeowner

        place_id = request.data.get('place')
        places = Place.objects.filter(place_owner=place_owner)

        place_serializer = PlaceSerializer(places, many=True)
        return Response(place_serializer.data)


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

