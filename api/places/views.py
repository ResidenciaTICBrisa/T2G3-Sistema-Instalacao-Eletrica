from django.shortcuts import render

from users.models import PlaceOwner
from rest_framework import generics
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from places.permissions import IsPlaceOwner
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.exceptions import NotFound

from .models import Place, Room
from .serializers import PlaceSerializer, RoomSerializer

class PlaceViewSet(viewsets.ModelViewSet):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = [IsAuthenticated]

    def get_place_owner(self, user):
        try:
            return user.placeowner
        except PlaceOwner.DoesNotExist:
            return PlaceOwner.objects.create(user=user)

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
        place_owner = self.get_place_owner(user)

        places = Place.objects.filter(place_owner=place_owner)

        place_serializer = PlaceSerializer(places, many=True)
        return Response(place_serializer.data)

    def retrieve(self, request, pk=None):
        place_owner_id = request.user.placeowner.id

        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.id == place_owner_id:
            serializer = PlaceSerializer(place)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

    def update(self, request, pk=None):
        place_owner_id = request.user.placeowner.id

        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.id == place_owner_id:
            serializer = PlaceSerializer(place, data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, pk=None):
        place_owner_id = request.user.placeowner.id

        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.id == place_owner_id:
            place.delete()
            return Response({"message": "Place deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

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

    def create(self, request, *args, **kwargs):
        user = request.user
        place_owner = user.placeowner
        place_id = request.data.get('place')

        place = get_object_or_404(Place, id=place_id, place_owner=place_owner)

        if place.place_owner == place_owner:
            room_serializer = RoomSerializer(data=request.data)
            room_serializer.is_valid(raise_exception=True)
            room_serializer.save()
            return Response(room_serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)
        
    def list(self,request,*args, **kwargs):
        user = request.user
        place_owner = user.placeowner
        place_id = request.query_params.get('place')

        if not place_id:
            raise NotFound("Place ID must be provided.")

        place = get_object_or_404(Place, id=place_id, place_owner=place_owner)

        rooms = Room.objects.filter(place=place)

        room_serializer = RoomSerializer(rooms, many=True)
        return Response(room_serializer.data)

    def retrieve(self, request, pk=None):
        place_owner = request.user.placeowner.id

        room = get_object_or_404(Room,pk=pk)

        if(room.place.place_owner.id == place_owner):
            serializer = RoomSerializer(room)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

    # Só o dono do lugar pode excluir uma sala espécífca
    def destroy(self, request, pk=None):
        place_owner_id = request.user.placeowner.id
        room = get_object_or_404(Room, pk=pk)

        if room.place.place_owner.id == place_owner_id:
            room.delete()
            return Response({"message": "Room deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this room"}, status=status.HTTP_403_FORBIDDEN)
