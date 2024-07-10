
# Generated by Django 4.2 on 2024-07-09 18:42

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0006_alter_placeowner_user'),
        ('places', '0031_remove_place_access_code'),
    ]

    operations = [
        migrations.AlterField(
            model_name='place',
            name='place_owner',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='places', to='users.placeowner'),
        ),
    ]
