import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/data/place_request_model.dart';
import 'package:sige_ie/places/data/place_service.dart';
import 'position.dart';

class NewPlace extends StatefulWidget {
  const NewPlace({super.key});

  @override
  NewPlaceState createState() => NewPlaceState();
}

class NewPlaceState extends State<NewPlace> {
  PlaceService placeService = PlaceService();
  String coordinates = '';
  bool coord = false;
  final nameController = TextEditingController();
  late PositionController positionController;
  late TextEditingController coordinatesController;

  @override
  void initState() {
    super.initState();
    positionController = PositionController();
    coordinatesController = TextEditingController();
  }

  void _getCoordinates() {
    positionController.getPosition().then((_) {
      setState(() {
        if (positionController.error.isEmpty) {
          coordinates =
              "Latitude: ${positionController.lat}, Longitude: ${positionController.lon}";
          coordinatesController.text = coordinates;
          coord = true;
        } else {
          coordinates = "Erro: ${positionController.error}";
          coordinatesController.text = coordinates;
          coord = false;
        }
      });
    }).catchError((e) {
      setState(() {
        coordinates = "Erro ao obter localização: $e";
        coordinatesController.text = coordinates;
        coord = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Text('Registrar Novo Local',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Coordenadas',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText:
                                  'Clique na lupa para obter as coordenadas',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            controller: coordinatesController,
                            enabled: false,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _getCoordinates,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text('Nome do Local',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Digite o nome do local',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeYellow),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeBlue),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (coord && nameController.text.trim().isNotEmpty) {
                        final PlaceService placeService = PlaceService();
                        final PlaceRequestModel place = PlaceRequestModel(
                            name: nameController.text,
                            lon: positionController.lon,
                            lat: positionController.lat);

                        int? placeId = await placeService.register(place);
                        if (placeId != null) {
                          Navigator.of(context)
                              .pushNamed('/arealocation', arguments: {
                            'placeName': nameController.text.trim(),
                            'placeId': placeId,
                          });
                        }
                      } else if (nameController.text.trim().isEmpty || !coord) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Erro"),
                              content: const Text(
                                  "Por favor, clique na lupa e insira um nome para o local"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('REGISTRAR'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
