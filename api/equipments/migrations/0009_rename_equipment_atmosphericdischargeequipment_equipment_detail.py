# Generated by Django 4.2 on 2024-04-24 20:23

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('equipments', '0008_alter_atmosphericdischargeequipment_table_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='atmosphericdischargeequipment',
            old_name='equipment',
            new_name='equipment_detail',
        ),
    ]
