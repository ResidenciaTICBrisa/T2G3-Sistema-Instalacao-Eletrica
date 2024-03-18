from django.urls import path
from .views import usuarios_list, usuario_detail

urlpatterns = [
    path('usuarios/', usuarios_list.as_view()),
    path('usuarios/<pk>/', usuario_detail.as_view())
]
