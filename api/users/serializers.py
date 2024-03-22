# serializers.py
from rest_framework import serializers, response
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'password']
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def create(self, validated_data):
        email = validated_data.get('email', None)
        if email is None:
            raise serializers.ValidationError("O campo de email é obrigatório")
        return super().create(validated_data)
