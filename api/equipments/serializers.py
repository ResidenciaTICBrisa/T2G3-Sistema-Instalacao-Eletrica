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

class DistributionBoardEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = DistributionBoardEquipment
        fields = '__all__'    
   
class ElectricalCircuitEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalCircuitEquipment
        fields = '__all__'    
   

class ElectricalLineEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalLineEquipment
        fields = '__all__'    
   
class ElectricalLoadEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = ElectricalLoadEquipment
        fields = '__all__'    
    
class IluminationEquipmentSerializer(serializers.ModelSerializer):

     class Meta:
        model = IluminationEquipment
        fields = '__all__'    
   