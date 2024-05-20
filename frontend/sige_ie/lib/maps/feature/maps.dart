import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/maps_controller.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapsController _controller = Get.put(MapsController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff123c75),
        elevation: 0,
        title: const Text('Google Maps',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Obx(() {
        return GoogleMap(
          onMapCreated: _controller.onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.571505, -46.689104), // Posição inicial
            zoom: 12,
          ),
          markers: Set<Marker>.of(_controller.markers),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        );
      }),
    );
  }
}
