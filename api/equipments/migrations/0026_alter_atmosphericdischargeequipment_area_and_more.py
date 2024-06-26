# Generated by Django 4.2 on 2024-06-17 16:34

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0031_remove_place_access_code'),
        ('equipments', '0025_alter_atmosphericdischargeequipment_area_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='atmosphericdischargeequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='distributionboardequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='electricalcircuitequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='electricallineequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='electricalloadequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='firealarmequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='iluminationequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='refrigerationequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
        migrations.AlterField(
            model_name='structuredcablingequipment',
            name='area',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='places.area'),
        ),
    ]
