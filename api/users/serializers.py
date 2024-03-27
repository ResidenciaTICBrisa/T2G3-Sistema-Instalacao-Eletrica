# serializers.py
from rest_framework import serializers, response
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ['id', 'password', 'username', 'first_name', 'email', 'is_active', 'date_joined', 'groups']
        extra_kwargs = {
            'password': {'write_only': True},
            'first_name': {'required': True},
            'email': {'required': True},
            'is_active': {'read_only': True},
            'date_joined': {'read_only': True},
            'groups': {'read_only': True}
        }
