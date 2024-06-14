from django.shortcuts import render
from rest_framework.views import APIView
from django.contrib.auth.models import User
from users.models import PlaceOwner, PlaceEditor
from rest_framework import generics
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from places.permissions import IsPlaceOwner
from rest_framework import viewsets, status
from rest_framework.decorators import action
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.exceptions import NotFound

from .models import Place, Area
from .serializers import PlaceSerializer, AreaSerializer

class PlaceViewSet(viewsets.ModelViewSet):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = [IsAuthenticated]

    def get_place_owner(self, user):
        try:
            return user.place_owner
        except PlaceOwner.DoesNotExist:
            return PlaceOwner.objects.create(user=user)

    def _has_permission(self, request, place):
        place_owner = place.place_owner
        return request.user == place_owner.user or place.editors.filter(user=request.user).exists()

    def create(self, request, *args, **kwargs):
        user = request.user

        try:
            place_owner = user.place_owner
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
        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.user == request.user or place.editors.filter(user=request.user).exists():
            serializer = PlaceSerializer(place)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this place"}, status=status.HTTP_403_FORBIDDEN)

    def update(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.user == request.user or place.editors.filter(user=request.user).exists():
            serializer = PlaceSerializer(place, data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this place"}, status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, pk=None):
        place_owner_id = request.user.place_owner.id

        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.id == place_owner_id:
            place.delete()
            return Response({"message": "Place deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

    @action(detail=True, methods=['get'])
    def areas(self, request, pk=None):
        place = self.get_object()
        serializer = AreaSerializer(place.areas.all(), many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'], url_path='areas/(?P<area_pk>\d+)')
    def area(self, request, pk=None, area_pk=None):
        place = self.get_object()
        area = get_object_or_404(place.areas.all(), pk=area_pk)
        serializer = AreaSerializer(area)
        return Response(serializer.data)

class AreaViewSet(viewsets.ModelViewSet):
    queryset = Area.objects.all()
    serializer_class = AreaSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        user = request.user
        place_owner = user.place_owner
        place_id = request.data.get('place')

        place = get_object_or_404(Place, id=place_id, place_owner=place_owner)

        if place.place_owner == place_owner:
            area_serializer = AreaSerializer(data=request.data)
            area_serializer.is_valid(raise_exception=True)
            area_serializer.save()
            return Response(area_serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)
        
    def list(self,request,*args, **kwargs):
        user = request.user
        place_owner = user.place_owner
        place_id = request.query_params.get('place')

        if not place_id:
            raise NotFound("Place ID must be provided.")

        place = get_object_or_404(Place, id=place_id, place_owner=place_owner)

        areas = Area.objects.filter(place=place)

        area_serializer = AreaSerializer(areas, many=True)
        return Response(area_serializer.data)

    def retrieve(self, request, pk=None):
        place_owner = request.user.place_owner.id

        area = get_object_or_404(Area,pk=pk)

        if(area.place.place_owner.id == place_owner):
            serializer = AreaSerializer(area)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner of this area"}, status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, pk=None):
        place_owner_id = request.user.place_owner.id
        area = get_object_or_404(Area, pk=pk)

        if area.place.place_owner.id == place_owner_id:
            area.delete()
            return Response({"message": "Area deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this area"}, status=status.HTTP_403_FORBIDDEN)

class GrantAccessViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated, IsPlaceOwner]

    @action(detail=True, methods=['post'])
    def grant_access(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        place_owner = place.place_owner

        if request.user != place_owner.user:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

        username = request.data.get('username')

        if not username:
            return Response({'error': 'Username is required'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_object_or_404(User, username=username)

        place_editor, created = PlaceEditor.objects.get_or_create(user=user)

        place.editors.add(place_editor)

        return Response({'message': 'Access granted successfully'}, status=status.HTTP_200_OK)