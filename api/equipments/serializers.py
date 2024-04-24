from rest_framework import serializers
from .models import EquipmentType, EquipmentDetail, AtmosphericDischargeEquipment

class EquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentType
        fields = '__all__'

class EquipmentDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentDetail
        fields = '__all__'

class AtmosphericDischargeEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = '__all__'        

