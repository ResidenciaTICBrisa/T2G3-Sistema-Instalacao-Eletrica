# views.py
from django.http import HttpResponse, JsonResponse
from rest_framework import viewsets, permissions, status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.authentication import BasicAuthentication
from rest_framework import generics
from django.views.decorators.csrf import ensure_csrf_cookie, csrf_protect, csrf_exempt
from .permissions import IsOwner
from .serializers import UserSerializer, UserLoginSerializer, UserUpdateSerializer
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.utils.decorators import method_decorator
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.core.mail import EmailMessage
from django.contrib.sites.shortcuts import get_current_site
from django.utils.http import urlsafe_base64_decode
from django.contrib.auth import get_user_model
from django.shortcuts import render, redirect
from django.contrib import messages

@method_decorator(ensure_csrf_cookie, name='dispatch')
class GetCSRFToken(APIView):
    permission_classes = [AllowAny]
    def get(self, request):
        return Response({'success':'CSRF Cookie Set'})

class GetSessionCookie(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        sessionid = request.COOKIES.get('sessionid')
        response = HttpResponse()
        response.set_cookie('sessionid', sessionid)
        return response

class CheckAuthenticatedView(APIView):
    permission_classes=[AllowAny]
    def get(self, request):
        if request.user.is_authenticated:
            return Response({'isAuthenticated': True})
        else:
            return Response({'isAuthenticated': False})

class UserCreateView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [AllowAny]

class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserUpdateSerializer
    permission_classes = [IsOwner, IsAuthenticated]

class AuthenticatedUserView(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        return self.request.user

class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self, request, format=None):          
            serializer = UserLoginSerializer(data=request.data)
            if(serializer.is_valid()):
                username = serializer.validated_data["username"]
                password = serializer.validated_data["password"]
                user = authenticate(username=username, password=password)
                if user is not None:
                    login(request, user)
                    return Response({'message': 'Login successful'}, status=status.HTTP_200_OK)
                else:
                    return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
            return JsonResponse(serializer.errors)

class LogoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, format=None):
        logout(request)
        return Response({'message': 'Logout successful'}, status=status.HTTP_200_OK)

class Email(APIView):
    permission_classes = []

    def post(self, request, *args, **kwargs):
        email = request.data.get('email')
        user = User.objects.filter(email=email).first()
        if user is not None:
            token = default_token_generator.make_token(user)
            mail_subject = 'Redefinição de senha'
            message = render_to_string('password_reset_email.html', {
                'user': user,
                'token': token,
            })
            email = EmailMessage(mail_subject, message, to=[email])
            email.send()
            return Response({'message': 'Email de redefinição de senha enviado'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'Usuário não encontrado'}, status=status.HTTP_404_NOT_FOUND)

class PasswordResetConfirmView(APIView):
    permission_classes = []
    def post(self, request):
        try:
            email = request.data.get("email")
            token = request.data.get("token")
            
            user = get_user_model().objects.get(email=email)
        except (TypeError, ValueError, OverflowError, get_user_model().DoesNotExist):
            user = None

        if user is not None and default_token_generator.check_token(user, token):
            new_password = request.data.get('new_password')
            confirm_password = request.data.get('confirm_password')
            if new_password == confirm_password:
                user.set_password(new_password)
                user.save()
                return Response({'message': 'Senha redefinida com sucesso'}, status=status.HTTP_200_OK)
            else:
                return Response({'message': 'As senhas não correspondem'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'message': 'O link de redefinição de senha é inválido'}, status=status.HTTP_400_BAD_REQUEST)
