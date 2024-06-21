import base64
from django.core.files.base import ContentFile
from rest_framework import serializers
from .models import *
from .serializers import *
from .mixins import ValidateAreaMixin

class PersonalEquipmentCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = PersonalEquipmentCategory
        fields = '__all__'

class PersonalEquipmentCategoryResponseSerializer(serializers.ModelSerializer):

    class Meta:
        model = PersonalEquipmentCategory
        fields = ['id', 'name']

class GenericEquipmentCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = GenericEquipmentCategory
        fields = '__all__'

class GenericEquipmentCategoryResponseSerializer(serializers.ModelSerializer):

    class Meta:
        model = GenericEquipmentCategory
        fields = ['id', 'name']

class EquipmentResponseSerializer(serializers.ModelSerializer):
    generic_equipment_category = serializers.CharField(source='generic_equipment_category.name', read_only=True)
    personal_equipment_category = serializers.CharField(source='personal_equipment_category.name', read_only=True)

    class Meta:
        model = Equipment
        fields = ['generic_equipment_category', 'personal_equipment_category']

class EquipmentPhotoSerializer(serializers.ModelSerializer):
    photo = serializers.CharField(write_only=True)

    class Meta:
        model = EquipmentPhoto
        fields = '__all__'

    def create(self, validated_data):
        photo_data = validated_data.pop('photo')
        try:
            format, imgstr = photo_data.split(';base64,')
            ext = format.split('/')[-1]
            photo = ContentFile(base64.b64decode(imgstr), name='temp.' + ext)
        except ValueError:
            raise serializers.ValidationError("Invalid image data")

        equipment_photo = EquipmentPhoto.objects.create(photo=photo, **validated_data)
        return equipment_photo

class FireAlarmEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = FireAlarmEquipment
        fields = '__all__'

class FireAlarmEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = FireAlarmEquipment
        fields = ['id', 'area', 'equipment', 'system']

class AtmosphericDischargeEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = '__all__'

class  AtmosphericDischargeEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = AtmosphericDischargeEquipment
        fields = ['id', 'area', 'equipment', 'system']

class StructuredCablingEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

    class Meta:
        model = StructuredCablingEquipment
        fields = '__all__' 

class StructuredCablingEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = StructuredCablingEquipment
        fields = ['id', 'area', 'equipment', 'system']

class DistributionBoardEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = DistributionBoardEquipment
        fields = '__all__'  

class DistributionBoardEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = StructuredCablingEquipment
        fields = ['id', 'area', 'equipment', 'system']

class ElectricalCircuitEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalCircuitEquipment
        fields = '__all__'  

class ElectricalCircuitEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = ElectricalCircuitEquipment
        fields = ['id', 'area', 'equipment', 'system']

class ElectricalLineEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLineEquipment
        fields = '__all__'   

class ElectricalLineEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = ElectricalLineEquipment
        fields = ['id', 'area', 'equipment', 'system']

class ElectricalLoadEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = ElectricalLoadEquipment
        fields = '__all__'  

class ElectricalLoadEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = ElectricalLoadEquipment
        fields = ['id', 'area', 'equipment', 'system']

class IluminationEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = IluminationEquipment
        fields = '__all__'   

class IluminationEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = IluminationEquipment
        fields = ['id', 'area', 'equipment', 'system']

class RefrigerationEquipmentSerializer(ValidateAreaMixin, serializers.ModelSerializer):

     class Meta:
        model = RefrigerationEquipment
        fields = '__all__'    

class RefrigerationEquipmentResponseSerializer(serializers.ModelSerializer):
    equipment = EquipmentResponseSerializer()

    class Meta:
        model = RefrigerationEquipment
        fields = ['id', 'area', 'equipment', 'system']

class EquipmentSerializer(serializers.ModelSerializer):

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
        model = Equipment
        fields = '__all__'
        extra_kwargs = {'place_owner': {'read_only': True}}
    
    def create(self, validated_data):
        request = self.context.get('request')
        validated_data['place_owner'] = request.user.place_owner

        fire_alarm_data = validated_data.pop('fire_alarm_equipment', None)
        atmospheric_discharge_data = validated_data.pop('atmospheric_discharge_equipment', None)
        structured_cabling_data = validated_data.pop('structured_cabling_equipment', None)
        distribution_board_data = validated_data.pop('distribution_board_equipment', None)
        electrical_circuit_data = validated_data.pop('electrical_circuit_equipment', None)
        electrical_line_data = validated_data.pop('electrical_line_equipment', None)
        electrical_load_data = validated_data.pop('electrical_load_equipment', None)
        ilumination_equipment_data = validated_data.pop('ilumination_equipment', None)
        refrigeration_equipment_data = validated_data.pop('refrigeration_equipment', None)

        equipment = Equipment.objects.create(**validated_data)

        if fire_alarm_data:
            FireAlarmEquipment.objects.create(equipment=equipment, **fire_alarm_data)
        elif atmospheric_discharge_data:
            AtmosphericDischargeEquipment.objects.create(equipment=equipment, **atmospheric_discharge_data)
        elif structured_cabling_data:
            StructuredCablingEquipment.objects.create(equipment=equipment, **structured_cabling_data)
        elif distribution_board_data:
            DistributionBoardEquipment.objects.create(equipment=equipment, **distribution_board_data)
        elif electrical_circuit_data:
            ElectricalCircuitEquipment.objects.create(equipment=equipment, **electrical_circuit_data)
        elif electrical_line_data:
            ElectricalLineEquipment.objects.create(equipment=equipment, **electrical_line_data)
        elif electrical_load_data:
            ElectricalLoadEquipment.objects.create(equipment=equipment, **electrical_load_data)
        elif ilumination_equipment_data:
            IluminationEquipment.objects.create(equipment=equipment, **ilumination_equipment_data)
        elif refrigeration_equipment_data:
            RefrigerationEquipment.objects.create(equipment=equipment, **refrigeration_equipment_data)

        return equipment