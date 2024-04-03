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

    def create(self, validated_data):
        user = User.objects.create_user(
        username=validated_data['username'],
        password=validated_data['password'],
        email=validated_data.get('email')  # use get se o email for opcional
        )
        return user

class UserSerializerP(serializers.Serializer):
    username = serializers.CharField(max_length=200)
    password = serializers.CharField(max_length=200)