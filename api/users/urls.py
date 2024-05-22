# urls.py
from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import GetCSRFToken, GetSessionCookie, CheckAuthenticatedView, UserCreateView, AuthenticatedUserView, UserDetailView, LoginView, LogoutView, Email, PasswordResetConfirmView
from django.urls import include

urlpatterns = [
    path('csrfcookie/', GetCSRFToken.as_view(), name='csrf-cookie'),
    path('sessioncookie/', GetSessionCookie.as_view(), name='session-cookie'),
    path('checkauth/', CheckAuthenticatedView.as_view(), name='check-auth'),
    path('users/', UserCreateView.as_view(), name='create-user'),
    path('userauth/', AuthenticatedUserView.as_view(), name='authenticated-user'),
    path('users/<pk>/', UserDetailView.as_view(), name='user_detail'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('recover/', Email.as_view()),
    path('reset/', PasswordResetConfirmView.as_view())
]
