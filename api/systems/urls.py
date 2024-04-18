from django.urls import path, include
from .views import SystemViewDetail, SystemViewList

urlpatterns = [
    path('systems/', SystemViewList.as_view()),
    path('systems/<pk>/', SystemViewDetail.as_view())

]

