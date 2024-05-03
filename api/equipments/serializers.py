from rest_framework import serializers
from .models import *
from .mixins import ValidateEquipmentDetailAndAreaMixin

class EquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentType
        fields = '__all__'

class EquipmentDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentDetail
        fields = '__all__'

class FireAlarmEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = FireAlarmEquipment
        fields = '__all__'
        extra_kwargs = {
            'system': {'read_only': True}
        }   

class AtmosphericDischargeEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = '__all__'
        extra_kwargs = {
            'system': {'read_only': True}
        }

class StructuredCablingEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = StructuredCablingEquipment
        fields = '__all__' 
        extra_kwargs = {
            'system': {'read_only': True}
        }  

class DistributionBoardEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = DistributionBoardEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        } 

class ElectricalCircuitEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalCircuitEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        }  

class ElectricalLineEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLineEquipment
        fields = '__all__'   
        extra_kwargs = {
            'system': {'read_only': True}
        } 
   
class ElectricalLoadEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLoadEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        }  
    
class IluminationEquipmentSerializer(ValidateEquipmentDetailAndAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = IluminationEquipment
        fields = '__all__'    
        extra_kwargs = {
            'system': {'read_only': True}
        }
