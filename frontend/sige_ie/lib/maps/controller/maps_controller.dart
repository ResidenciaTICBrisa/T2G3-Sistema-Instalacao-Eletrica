import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../places/data/place_response_model.dart';
import '../../places/data/place_service.dart';

class MapsController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final markers = <Marker>{}.obs;
  final isLoading = true.obs;

  final PlaceService _placeService = PlaceService();
  late CameraPosition initialCameraPosition;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
    fetchPlaces();
  }

  void onMapCreated(GoogleMapController controller) {}

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifique se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Erro', 'Serviço de localização está desabilitado.');
      return;
    }

    // Verifique se a permissão de localização é concedida
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Erro', 'Permissão de localização negada.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Erro', 'Permissão de localização negada permanentemente.');
      return;
    }

    // Obtenha a localização atual
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    initialCameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 12,
    );

    isLoading.value = false;
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
          ?.buffer
          .asUint8List();
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao carregar ícone: $e');
      return null;
    }
  }

  Future<void> fetchPlaces() async {
    try {
      final List<PlaceResponseModel> places =
          await _placeService.fetchAllPlaces();
      for (var place in places) {
        await addMarker(place);
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao carregar locais: $e');
    }
  }

  Future<void> addMarker(PlaceResponseModel place) async {
    final Uint8List? icon = await getBytesFromAsset('assets/lighting.png', 80);
    if (icon != null) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          position: LatLng(place.lat, place.lon),
          infoWindow: InfoWindow(title: place.name),
          icon: BitmapDescriptor.fromBytes(icon),
        ),
      );
    } else {
      Get.snackbar('Erro', 'Falha ao carregar ícone do marcador');
    }
  }
}
