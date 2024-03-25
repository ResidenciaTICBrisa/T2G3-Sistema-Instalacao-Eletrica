# urls.py
from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import UserCreateView, UserDetailView, LoginView, LogoutView
from django.urls import include, path

urlpatterns = [
    path('users/', UserCreateView.as_view()),
    path('users/<pk>/', UserDetailView.as_view()),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
]
