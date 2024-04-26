from rest_framework import serializers
from .models import EquipmentType, EquipmentDetail, AtmosphericDischargeEquipment, FireAlarmEquipment, SructeredCablingEquipment

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

class FireAlarmEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = FireAlarmEquipment
        fields = '__all__'    

class SructeredCablingEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = SructeredCablingEquipment
        fields = '__all__'    

