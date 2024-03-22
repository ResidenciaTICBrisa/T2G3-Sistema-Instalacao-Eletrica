# serializers.py
from rest_framework import serializers, response
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'password']
        extra_kwargs = {
            'first_name': {'required': True},
            'email': {'required': True}
        }
