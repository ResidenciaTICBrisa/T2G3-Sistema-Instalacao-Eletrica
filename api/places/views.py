from rest_framework.views import APIView
from django.db.models import Q
from django.contrib.auth.models import User
from users.models import PlaceOwner, PlaceEditor
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from places.permissions import *
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.exceptions import NotFound
from django.http import HttpResponse
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from reportlab.lib.colors import black,red
from .models import Place, Area
from .serializers import PlaceSerializer, AreaSerializer
from weasyprint import HTML
from django.templatetags.static import static
from django.template.loader import render_to_string
from PyPDF2 import PdfReader, PdfWriter
from io import BytesIO
from datetime import datetime
import pytz



def get_place_owner_or_create(user):
    try:
        return user.place_owner
    except PlaceOwner.DoesNotExist:
        return PlaceOwner.objects.create(user=user)


class PlaceViewSet(viewsets.ModelViewSet):
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = [IsAuthenticated, IsPlaceOwner | IsPlaceEditor]

    def create(self, request, *args, **kwargs):
        user = request.user
        place_owner = get_place_owner_or_create(user)

        place_data = request.data.copy()
        place_data['place_owner'] = place_owner.id
        place_serializer = self.get_serializer(data=place_data)
        place_serializer.is_valid(raise_exception=True)
        self.perform_create(place_serializer)

        headers = self.get_success_headers(place_serializer.data)
        return Response(place_serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        user = request.user
        place_owner = get_place_owner_or_create(user)

        places = Place.objects.filter(
            Q(place_owner=place_owner) |
            Q(editors__user=user)
        ).distinct()

        place_serializer = PlaceSerializer(places, many=True)
        return Response(place_serializer.data)

    def retrieve(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        user = request.user
        place_owner = get_place_owner_or_create(user)
        if place.place_owner.id == place_owner.id or place.editors.filter(user=user).exists():
            serializer = PlaceSerializer(place)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this place"},
                            status=status.HTTP_403_FORBIDDEN)

    def update(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        user = request.user
        place_owner = get_place_owner_or_create(user)
        if place.place_owner.id == place_owner.id or place.editors.filter(user=user).exists():
            serializer = PlaceSerializer(place, data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this place"},
                            status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, pk=None):
        user = request.user
        place_owner = get_place_owner_or_create(user)

        place = get_object_or_404(Place, pk=pk)
        if place.place_owner.id == place_owner.id:
            place.delete()
            return Response({"message": "Place deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

    @action(detail=True, methods=['get'], permission_classes=[IsAuthenticated, IsPlaceOwner | IsPlaceEditor])
    def areas(self, request, pk=None):
        place = self.get_object()
        serializer = AreaSerializer(place.areas.all(), many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'], url_path='areas/(?P<area_pk>\d+)',
            permission_classes=[IsAuthenticated])
    def area(self, request, pk=None, area_pk=None):
        place = self.get_object()
        area = get_object_or_404(place.areas.all(), pk=area_pk)
        if(request.user.place_owner == area.place.place_owner or area.place.editors.filter(user=request.user).exists()):
            serializer = AreaSerializer(area)
            return Response(serializer.data)
        return Response({"Error" : "You're not the owner or editor of this Area"})


class AreaViewSet(viewsets.ModelViewSet):
    queryset = Area.objects.all()
    serializer_class = AreaSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        user = request.user
        place_owner = get_place_owner_or_create(user)
        place_id = request.data.get('place')
        place = get_object_or_404(Place, id=place_id)

        if place.place_owner.id == place_owner.id or place.editors.filter(user=user).exists():
            area_serializer = AreaSerializer(data=request.data)
            area_serializer.is_valid(raise_exception=True)
            area_serializer.save()
            return Response(area_serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"message": "You are not the owner or an editor of this place"},
                            status=status.HTTP_403_FORBIDDEN)

    def list(self, request, *args, **kwargs):
        user = request.user
        place_owner = get_place_owner_or_create(user)
        place_id = request.query_params.get('place')

        if not place_id:
            raise NotFound("Place ID must be provided.")

        place = get_object_or_404(Place, id=place_id)

        if place.place_owner.id == place_owner.id or place.editors.filter(user=user).exists():
            areas = Area.objects.filter(place=place)
            area_serializer = AreaSerializer(areas, many=True)
            return Response(area_serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this place"},
                            status=status.HTTP_403_FORBIDDEN)

    def retrieve(self, request, pk=None):
        user = request.user
        place_owner = get_place_owner_or_create(user)

        area = get_object_or_404(Area, pk=pk)

        if area.place.place_owner.id == place_owner.id or area.place.editors.filter(user=user).exists():
            serializer = AreaSerializer(area)
            return Response(serializer.data)
        else:
            return Response({"message": "You are not the owner or an editor of this area"},
                            status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, pk=None):
        user = request.user
        place_owner = get_place_owner_or_create(user)
        area = get_object_or_404(Area, pk=pk)

        if area.place.place_owner.id == place_owner.id:
            area.delete()
            return Response({"message": "Area deleted successfully"}, status=status.HTTP_204_NO_CONTENT)
        else:
            return Response({"message": "You are not the owner of this area"}, status=status.HTTP_403_FORBIDDEN)


class RefuseAccessViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated, IsPlaceOwner]

    @action(detail=True, methods=['post'])
    def refuse_access(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        place_owner = place.place_owner

        if request.user != place_owner.user:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

        username = request.data.get('username')

        if not username:
            return Response({'error': 'Username is required'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_object_or_404(User, username=username)

        place_editor = PlaceEditor.objects.filter(user=user).first()

        if not place_editor:
            return Response({'error': 'This user is not an editor of the place'}, status=status.HTTP_400_BAD_REQUEST)

        place.editors.remove(place_editor)

        return Response({'message': 'Access revoked successfully'}, status=status.HTTP_200_OK)

class GrantAccessViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated, IsPlaceOwner]

    @action(detail=True, methods=['post'])
    def grant_access(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        place_owner = place.place_owner

        if request.user != place_owner.user:
            return Response({"message": "You are not the owner of this place"}, status=status.HTTP_403_FORBIDDEN)

        username = request.data.get('username')

        if not username:
            return Response({'error': 'Username is required'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_object_or_404(User, username=username)

        place_editor, created = PlaceEditor.objects.get_or_create(user=user)

        place.editors.add(place_editor)

        return Response({'message': 'Access granted successfully'}, status=status.HTTP_200_OK)


def genericOrPersonal(system):
    if system.equipment.generic_equipment_category is not None:
        return system.equipment.generic_equipment_category
    else:
        return system.equipment.personal_equipment_category


class PDFView(APIView):
    permission_classes = [IsAuthenticated, IsPlaceOwner or IsPlaceEditor]
    def get(self, request, pk=None):
        place = get_object_or_404(Place, pk=pk)
        self.check_object_permissions(request, place)

        timezone = pytz.timezone('America/Sao_Paulo')
        report_data = {
            'report_date': f'{datetime.now(timezone).strftime("%d/%m/%Y")}',
            'summary': f'Este relatório cobre as instalações elétricas do local: {place.name}',
            'installations': [],
            'generated_by': f'{request.user}'
        }
    
        for area in place.areas.all():
            for system in area.fire_alarm_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({'image_url': image.photo.url, 'description': image.description})
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}',
                    'observation': f'{system.observation}',
                })

            for system in area.atmospheric_discharge_equipment.all():
                photos = []
                for image in system.atmospheric_discharge_equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos
                })

            for system in area.structured_cabling_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}'
                })

            for system in area.distribution_board_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'power': f'{system.power}',
                    'dr': f'{"Sim" if system.dr else "Não"}',
                    'dps': f'{"Sim" if system.dps else "Não"}',
                    'grounding': f'{"Sim" if system.grounding else "Não"}',
                    'type_material': f'{system.type_material}',
                    'method_installation': f'{system.method_installation}',
                    'quantity': f'{system.quantity}',
                    'observation': f'{system.observation}'
                })

            for system in area.electrical_circuit_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'size': f'{system.size}',
                    'type_wire': f'{system.type_wire}',
                    'type_circuit_breaker': f'{system.type_circuit_breaker}',
                    'observation': f'{system.observation}'
                })

            for system in area.electrical_line_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}',
                    'observation': f'{system.observation}'
                })

            for system in area.electrical_load_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'system': f'{system.system}',
                    'type': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}',
                    'power': f'{system.power}',
                    'brand': f'{system.brand}',
                    'model': f'{system.model}',
                    'observation': f'{system.observation}'                                    
                })

            for system in area.ilumination_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'sistema': f'{system.system}',
                    'tipo': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}',
                    'power': f'{system.power}',
                    'tecnology': f'{system.tecnology}',
                    'format': f'{system.format}',
                    'observation': f'{system.observation}'
                })

            for system in area.refrigeration_equipment.all():
                photos = []
                for image in system.equipment.ephoto.all():
                    photos.append({
                        'image_url': image.photo.url,
                        'description': image.description
                    })
                report_data['installations'].append({
                    'area': f'{area.name}',
                    'sistema': f'{system.system}',
                    'tipo': f'{genericOrPersonal(system)}',
                    'photos': photos,
                    'quantity': f'{system.quantity}',
                    'power': f'{system.power}',
                    'observation': f'{system.observation}'
                    
                })
    
        # Renderizar o template HTML com os dados do relatório
        html_content = render_to_string('html/index.html', report_data)

        # Gerar o PDF a partir do HTML renderizado
        pdf1 = HTML(string=html_content).write_pdf()

        # Retorna o PDF como uma resposta HTTP
        response = HttpResponse(pdf1, content_type='application/pdf')
        response['Content-Disposition'] = 'inline; filename="relatorio.pdf"'
        
        return response
