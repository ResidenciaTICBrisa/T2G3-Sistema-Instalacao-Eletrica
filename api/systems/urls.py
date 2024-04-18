from django.urls import path, include
from .views import SystemViewDetail, SystemViewList, EquipmentTypeList, EquipmentTypeDetail

urlpatterns = [
    path('systems/', SystemViewList.as_view()),
    path('systems/<pk>/', SystemViewDetail.as_view()),
    path('equipment-type/', EquipmentTypeList.as_view()),
    path('equipment-type/<pk>/', EquipmentTypeDetail.as_view())

]

