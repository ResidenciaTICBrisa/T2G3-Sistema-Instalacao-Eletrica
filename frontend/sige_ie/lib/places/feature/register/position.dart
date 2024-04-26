import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionController extends ChangeNotifier {
  double lat = 0.0;
  double lon = 0.0;
  String error = '';

  PositionController() {
    getPosition();
  }

  getPosition() async {
    try {
      Position position = await _currentPostion();
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }
}

Future<Position> _currentPostion() async {
  LocationPermission permission;
  bool active = await Geolocator.isLocationServiceEnabled();
  if (!active) {
    return Future.error("Por favor, autorize o acesso a localização");
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Por favor, autorize o acesso a localização");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Autorize o acesso a localização");
  }

  return await Geolocator.getCurrentPosition();
}
