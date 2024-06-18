# Generated by Django 4.2 on 2024-06-12 13:26

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('users', '0004_alter_placeowner_user'),
    ]

    operations = [
        migrations.CreateModel(
            name='PlaceEditor',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='place_editor', to=settings.AUTH_USER_MODEL, verbose_name='user')),
            ],
        ),
    ]