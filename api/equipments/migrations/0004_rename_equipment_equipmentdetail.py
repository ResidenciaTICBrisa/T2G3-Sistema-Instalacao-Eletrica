# Generated by Django 4.2 on 2024-04-24 18:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0004_alter_placeowner_user'),
        ('equipments', '0003_atmosphericdischargeequipment'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Equipment',
            new_name='EquipmentDetail',
        ),
    ]