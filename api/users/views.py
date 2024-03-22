# views.py
from rest_framework import viewsets, permissions, status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from rest_framework.authentication import TokenAuthentication
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from rest_framework import generics
from .serializers import UserSerializer 
from django.contrib.auth.models import User

@method_decorator(csrf_exempt, name='dispatch')
class UserListView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []
    authentication_classes = [TokenAuthentication]

@method_decorator(csrf_exempt, name='dispatch')
class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []
    authentication_classes = [TokenAuthentication]

class LoginView(APIView):
    authentication_classes = []
    permission_classes = []

    def post(self, request, format=None):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return Response({'message': 'Login successful'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class LogoutView(APIView):
    authentication_classes = [SessionAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, format=None):
        logout(request)
        return Response({'message': 'Logout successful'}, status=status.HTTP_200_OK)
