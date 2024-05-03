from rest_framework import serializers
from .models import *

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

class AtmosphericDischargeEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = '__all__'
        extra_kwargs = {
            'system': {'read_only': True}
        }  

class StructuredCablingEquipmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = StructuredCablingEquipment
        fields = '__all__' 
        extra_kwargs = {
            'system': {'read_only': True}
        }  

class DistributionBoardEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = DistributionBoardEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        } 

class ElectricalCircuitEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalCircuitEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        }  

class ElectricalLineEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalLineEquipment
        fields = '__all__'   
        extra_kwargs = {
            'system': {'read_only': True}
        } 
   
class ElectricalLoadEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalLoadEquipment
        fields = '__all__'  
        extra_kwargs = {
            'system': {'read_only': True}
        }  
    
class IluminationEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = IluminationEquipment
        fields = '__all__'    
        extra_kwargs = {
            'system': {'read_only': True}
        }
