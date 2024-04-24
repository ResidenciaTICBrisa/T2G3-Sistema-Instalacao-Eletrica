# Generated by Django 4.2 on 2024-04-24 18:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0021_room_place_room_systems'),
        ('equipments', '0002_equipment_placeowner_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='AtmosphericDischargeEquipment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('equipment', models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to='equipments.equipment')),
                ('room', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.room')),
            ],
        ),
    ]