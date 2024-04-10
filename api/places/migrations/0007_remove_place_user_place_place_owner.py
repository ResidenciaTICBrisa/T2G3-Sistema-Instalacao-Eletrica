# Generated by Django 4.2 on 2024-04-10 18:53

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
        ('places', '0006_room_systems'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='place',
            name='user',
        ),
        migrations.AddField(
            model_name='place',
            name='place_owner',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='users.placeowner'),
        ),
    ]
