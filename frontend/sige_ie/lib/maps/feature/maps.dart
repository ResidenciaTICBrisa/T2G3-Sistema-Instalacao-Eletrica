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
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: const BoxDecoration(
                color: Color(0xff123c75),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Text(
                      'Mapa',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: _controller.onMapCreated,
                initialCameraPosition: _controller.initialCameraPosition,
                markers: Set<Marker>.of(_controller.markers),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ],
        );
      }),
    );
  }
}
