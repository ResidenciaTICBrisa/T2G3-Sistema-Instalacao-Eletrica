from rest_framework import generics
from .serializers import userSerializer 
from django.contrib.auth.models import User

# Create your views here.

class usuarios_list(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = userSerializer

class usuario_detail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = userSerializer