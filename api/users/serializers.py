# serializers.py
from rest_framework import serializers, response
from django.contrib.auth.models import User
from .models import PlaceOwner

class UserSerializer(serializers.ModelSerializer):
    username = serializers.CharField(min_length=6, max_length=23, required=True)
    password = serializers.CharField(min_length=6, max_length=200, write_only=True)
    first_name = serializers.CharField(required=True)
    email = serializers.EmailField(required=True)

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
            first_name=validated_data['first_name'],
            email=validated_data.get('email')
        )
        return user

class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField(min_length=6, max_length=23, required=True)
    password = serializers.CharField(min_length=6, max_length=200, required=True)


class UserUpdateSerializer(serializers.Serializer):
    first_name = serializers.CharField(required=True)
    email = serializers.EmailField(required=True)

    def update(self, instance, validated_data):
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.email = validated_data.get('email', instance.email)
        instance.save()
        return instance

class PlaceOwnerSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlaceOwner
        fields = ['id']
