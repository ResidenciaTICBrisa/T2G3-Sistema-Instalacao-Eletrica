# urls.py
from django.urls import path
from .views import GetCSRFToken, GetSessionCookie, CheckAuthenticatedView, UserCreateView, AuthenticatedUserView, UserDetailView, LoginView, LogoutView, ChangeUsername, ChangePassword, EmailView, PasswordResetConfirmView

urlpatterns = [
    path('csrfcookie/', GetCSRFToken.as_view(), name='csrf-cookie'),
    path('sessioncookie/', GetSessionCookie.as_view(), name='session-cookie'),
    path('checkauth/', CheckAuthenticatedView.as_view(), name='check-auth'),
    path('users/', UserCreateView.as_view(), name='create-user'),
    path('userauth/', AuthenticatedUserView.as_view(), name='authenticated-user'),
    path('users/<pk>/', UserDetailView.as_view(), name='user_detail'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('change_username/', ChangeUsername.as_view(), name='change username'),
    path('change_password/', ChangePassword.as_view(), name='change password'),
    path('recover/', EmailView.as_view(), name='Email'),
    path('reset/', PasswordResetConfirmView.as_view(), name='password-reset'),
]
