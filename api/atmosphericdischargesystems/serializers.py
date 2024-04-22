from rest_framework import serializers
from .models import AtmosphericDischargeSystem


class AtmosphericDischargeSystemSerializer(serializers.ModelSerializer):
    class meta:
        model = AtmosphericDischargeSystem
        fields = ['id','place','equipment']