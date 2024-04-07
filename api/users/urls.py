# urls.py
from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import GetCSRFToken, GetSessionCookie, CheckAuthenticatedView, UserCreateView, AuthenticatedUserView, UserDetailView, LoginView, LogoutView
from django.urls import include

urlpatterns = [
    path('csrfcookie/', GetCSRFToken.as_view(), name='csrf-cookie'),
    path('sessioncookie/', GetSessionCookie.as_view(), name='session-cookie'),
    path('checkauth/', CheckAuthenticatedView.as_view(), name='check-auth'),
    path('users/', UserCreateView.as_view()),
    path('userauth/', AuthenticatedUserView.as_view(), name='authenticated-user'),
    path('users/<pk>/', UserDetailView.as_view()),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
]
