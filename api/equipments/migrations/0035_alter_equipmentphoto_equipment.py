# Generated by Django 4.2 on 2024-08-07 12:42

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('equipments', '0034_atmosphericdischargeequipment_quantity_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='equipmentphoto',
            name='equipment',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='ephoto', to='equipments.equipment'),
        ),
    ]
