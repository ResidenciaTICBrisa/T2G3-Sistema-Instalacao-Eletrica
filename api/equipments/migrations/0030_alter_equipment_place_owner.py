# Generated by Django 4.2 on 2024-06-21 18:13

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0006_alter_placeowner_user'),
        ('equipments', '0029_alter_equipment_place_owner_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='equipment',
            name='place_owner',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='users.placeowner'),
        ),
    ]