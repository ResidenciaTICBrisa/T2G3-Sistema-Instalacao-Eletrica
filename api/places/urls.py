from django.urls import path, include
from .views import *
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register(r'places',PlaceViewSet)
router.register(r'areas', AreaViewSet)
router.register(r'grant_access', GrantAccessViewSet, basename='grant_access')
router.register(r'refuse_access', RefuseAccessViewSet, basename = 'refuse_access')

urlpatterns = [
    path('places/<int:pk>/report/', PDFView.as_view(), name='place-report')]