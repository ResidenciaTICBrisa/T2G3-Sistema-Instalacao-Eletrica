import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../places/data/place_response_model.dart';
import '../../places/data/place_service.dart';

class MapsController extends GetxController {
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final markers = <Marker>{}.obs;

  late GoogleMapController _mapsController;
  final PlaceService _placeService = PlaceService();

  @override
  void onInit() {
    super.onInit();
    fetchPlaces();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapsController = controller;
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
    final Uint8List? icon = await getBytesFromAsset('assets/lighting.png', 64);
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
