from django.urls import path, include
from .views import PlacesList, PlaceDetail

urlpatterns = [
    path("places/", PlacesList.as_view()),
    path("place/<pk>/", PlaceDetail.as_view())
]
