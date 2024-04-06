from django.db import models
from django.core.validators import MinValueValidator
from django.contrib.auth.models import User
from django.contrib.auth.models import Permission, Group
from django.contrib.contenttypes.models import ContentType

class Place(models.Model):

    name = models.CharField(max_length=50)
    user = models.ForeignKey(User, verbose_name=("creator"), on_delete=models.CASCADE)

    def __str__(self):
        return self.name

class Room(models.Model):

    name = models.CharField(max_length=50)
    floor = models.IntegerField(default=0, validators=[MinValueValidator(0)])
    place = models.ForeignKey(Place, related_name='rooms', on_delete=models.CASCADE)
    systems = models.ManyToManyField('systems.System')


def criar_permissoes_place(sender, instance, created, **kwargs):

    if created:

        content_type = ContentType.objects.get_for_model(Place)

        permission_view = Permission.objects.create(
            codename='view_content_{}'.format(instance.id),
            name='Can view content of {}'.format(instance.name),
            content_type=content_type
        )
        permission_edit = Permission.objects.create(
            codename='edit_content_{}'.format(instance.id),
            name='Can edit content of {}'.format(instance.name),
            content_type=content_type
        )

        permission_delet = Permission.objects.create(
            codename='delete_instance_{}'.format(instance.id),
            name="Can delete the instance of {}".format(instance.name),
            content_type = content_type


        )
        group_view = Group.objects.create(name='Visualizadores {}'.format(instance.name))
        group_view.permissions.add(permission_view)

        group_edit = Group.objects.create(name='Editores {}'.format(instance.name))
        group_edit.permissions.add(permission_view)
        group_edit.permissions.add(permission_edit)

        group_owner = Group.objects.create(name='Donos {}'.format(instance.name))
        group_owner.permissions.add(permission_delet)
        group_owner.permissions.add(permission_edit)
        group_owner.permissions.add(permission_view)

        usuario = instance.user_id
        direitos = Group.objects.get(name='Donos {}'.format(instance.name))
        direitos.user_set.add(usuario)

  


models.signals.post_save.connect(criar_permissoes_place, sender=Place)

