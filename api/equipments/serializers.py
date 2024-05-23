from rest_framework import serializers
from .models import *
from .mixins import ValidateAreaMixin

class PersonalEquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = PersonalEquipmentType
        fields = '__all__'

class EquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentType
        fields = '__all__'

class EquipmentDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentDetail
        fields = '__all__'

class FireAlarmEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = FireAlarmEquipment
        fields = '__all__'

class AtmosphericDischargeEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = '__all__'

class StructuredCablingEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = StructuredCablingEquipment
        fields = '__all__' 

class DistributionBoardEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = DistributionBoardEquipment
        fields = '__all__'  

class ElectricalCircuitEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalCircuitEquipment
        fields = '__all__'  

class ElectricalLineEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLineEquipment
        fields = '__all__'   

class ElectricalLoadEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLoadEquipment
        fields = '__all__'  

class IluminationEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = IluminationEquipment
        fields = '__all__'    

class RefrigerationEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = RefrigerationEquipment
        fields = '__all__'    
