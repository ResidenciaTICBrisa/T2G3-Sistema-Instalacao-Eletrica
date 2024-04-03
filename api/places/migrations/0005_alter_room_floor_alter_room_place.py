# Generated by Django 4.2 on 2024-03-27 22:26

import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0004_room'),
    ]

    operations = [
        migrations.AlterField(
            model_name='room',
            name='floor',
            field=models.IntegerField(default=0, validators=[django.core.validators.MinValueValidator(0)]),
        ),
        migrations.AlterField(
            model_name='room',
            name='place',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='rooms', to='places.place'),
        ),
    ]