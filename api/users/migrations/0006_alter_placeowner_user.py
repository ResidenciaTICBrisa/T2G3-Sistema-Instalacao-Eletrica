# Generated by Django 4.2 on 2024-06-14 13:54

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('users', '0005_placeeditor'),
    ]

    operations = [
        migrations.AlterField(
            model_name='placeowner',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='place_owner', to=settings.AUTH_USER_MODEL, verbose_name='user'),
        ),
    ]