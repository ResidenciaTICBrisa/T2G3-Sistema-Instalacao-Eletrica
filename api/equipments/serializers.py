from rest_framework import serializers
from .models import *
from .serializers import *
from .mixins import ValidateAreaMixin

class PersonalEquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = PersonalEquipmentType
        fields = '__all__'

class EquipmentTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentType
        fields = '__all__'

class EquipmentPhotoSerializer(serializers.ModelSerializer):

    class Meta:
        model = EquipmentPhoto
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

class EquipmentDetailSerializer(serializers.ModelSerializer):

    photos = EquipmentPhotoSerializer(many=True, required=False)

    fire_alarm_equipment = FireAlarmEquipmentSerializer(required=False)
    atmospheric_discharge_equipment = AtmosphericDischargeEquipmentSerializer(required=False)
    structured_cabling_equipment = StructuredCablingEquipmentSerializer(required=False)
    distribution_board_equipment = DistributionBoardEquipmentSerializer(required=False)
    electrical_circuit_equipment = ElectricalCircuitEquipmentSerializer(required=False)
    electrical_line_equipment  = ElectricalLineEquipmentSerializer(required=False)
    electrical_load_equipment = ElectricalLoadEquipmentSerializer(required=False)
    ilumination_equipment = IluminationEquipmentSerializer(required=False)
    refrigeration_equipment = RefrigerationEquipmentSerializer(required=False)

    class Meta:
        model = EquipmentDetail
        fields = '__all__'
        extra_kwargs = {'place_owner': {'read_only': True}}
    
    def create(self, validated_data):
        request = self.context.get('request')
        validated_data['place_owner'] = request.user.placeowner

        photos_data = validated_data.pop('photos', [])

        fire_alarm_data = validated_data.pop('fire_alarm_equipment', None)
        atmospheric_discharge_data = validated_data.pop('atmospheric_discharge_equipment', None)
        structured_cabling_data = validated_data.pop('structured_cabling_equipment', None)
        distribution_board_data = validated_data.pop('distribution_board_equipment', None)
        electrical_circuit_data = validated_data.pop('electrical_circuit_equipment', None)
        electrical_line_data = validated_data.pop('electrical_line_equipment', None)
        electrical_load_data = validated_data.pop('electrical_load_equipment', None)
        ilumination_equipment_data = validated_data.pop('ilumination_equipment', None)
        refrigeration_equipment_data = validated_data.pop('refrigeration_equipment', None)

        equipment_detail = EquipmentDetail.objects.create(**validated_data)

        for photo_data in photos_data:
            EquipmentPhoto.objects.create(equipment_detail=equipment_detail, **photo_data)

        if fire_alarm_data:
            FireAlarmEquipment.objects.create(equipment_detail=equipment_detail, **fire_alarm_data)
        elif atmospheric_discharge_data:
            AtmosphericDischargeEquipment.objects.create(equipment_detail=equipment_detail, **atmospheric_discharge_data)
        elif structured_cabling_data:
            StructuredCablingEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **structured_cabling_data)
        elif distribution_board_data:
            DistributionBoardEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **distribution_board_data)
        elif electrical_circuit_data:
            ElectricalCircuitEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **electrical_circuit_data)
        elif electrical_line_data:
            ElectricalLineEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **electrical_line_data)
        elif electrical_load_data:
            ElectricalLoadEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **electrical_load_data)
        elif ilumination_equipment_data:
            IluminationEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **ilumination_equipment_data)
        elif refrigeration_equipment_data:
            RefrigerationEquipmentSerializer.objects.create(equipment_detail=equipment_detail, **refrigeration_equipment_data)

        return equipment_detail