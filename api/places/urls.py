from django.urls import path, include
from .views import *
from rest_framework.routers import SimpleRouter
from .views import GeneratePDFView

router = SimpleRouter()
router.register(r'places',PlaceViewSet)
router.register(r'areas', AreaViewSet)
router.register(r'grant_access', GrantAccessViewSet, basename='grant_access')
router.register(r'refuse_access', RefuseAccessViewSet, basename = 'refuse_access')

urlpatterns = [
    path('places/<int:pk>/report/', GeneratePDFView.as_view(), name='place-report'),
]