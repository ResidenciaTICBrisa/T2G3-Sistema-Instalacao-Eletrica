from django.urls import path, include
from .views import PlaceViewSet, AreaViewSet, GrantAccessViewSet
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register(r'places',PlaceViewSet)
router.register(r'areas', AreaViewSet)
router.register(r'grant_access', GrantAccessViewSet, basename='grant_access')