# Generated by Django 4.2 on 2024-05-23 14:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('places', '0027_alter_area_floor'),
    ]

    operations = [
        migrations.AddField(
            model_name='place',
            name='photo',
            field=models.ImageField(null=True, upload_to='place_photos/'),
        ),
    ]
