from rest_framework import serializers
from .models import System

class SystemSerializer(serializers.ModelSerializer):
    class Meta:
        model = System
        fields = ['id', 'name']
