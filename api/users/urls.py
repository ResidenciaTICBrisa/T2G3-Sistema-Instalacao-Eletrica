# urls.py
from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import UserListView, UserDetailView, LoginView, LogoutView
from django.urls import include, path

urlpatterns = [
    path('users/', UserListView.as_view()),
    path('users/<pk>/', UserDetailView.as_view()),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
]
