from django.urls import path, include
from .views import PlaceViewSet, RoomViewSet
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register('places',PlaceViewSet)
router.register('rooms', RoomViewSet)