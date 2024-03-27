from django.urls import path, include
from .views import PlacesList

urlpatterns = [
    path("places/", PlacesList.as_view())
]
