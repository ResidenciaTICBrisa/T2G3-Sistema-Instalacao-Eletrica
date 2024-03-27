from django.urls import path, include
from .views import PlacesList, PlaceDetail, RoomsList, RoomDetail

urlpatterns = [
    path("places/", PlacesList.as_view()),
    path("place/<pk>/", PlaceDetail.as_view()),
    path("place/<int:place_id>/rooms/", RoomsList.as_view()),
    path("place/<int:place_id>/room/<pk>/", RoomDetail.as_view())
]
