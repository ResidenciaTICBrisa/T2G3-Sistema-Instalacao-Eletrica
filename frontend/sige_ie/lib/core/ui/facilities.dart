import 'package:flutter/material.dart';
import 'package:sige_ie/areas/data/area_response_model.dart';
import 'package:sige_ie/places/data/place_request_model.dart';
import 'package:sige_ie/places/data/place_response_model.dart';
import 'package:sige_ie/places/data/place_service.dart';
import '../../config/app_styles.dart';
import '../../areas/data/area_service.dart';

class FacilitiesPage extends StatefulWidget {
  @override
  _FacilitiesPageState createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  late Future<List<PlaceResponseModel>> _placesList;
  final PlaceService _placeService = PlaceService();
  final AreaService _areaService = AreaService();

  @override
  void initState() {
    super.initState();
    _placesList = _placeService.fetchAllPlaces();
  }

  Future<List<AreaResponseModel>> _loadAreasForPlace(int placeId) async {
    try {
      return await _areaService.fetchAreasByPlaceId(placeId);
    } catch (e) {
      print('Erro ao carregar áreas: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  void _confirmDelete(BuildContext context, PlaceResponseModel place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content:
              Text('Você realmente deseja excluir o local "${place.name}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text('Excluir'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  bool success = await _placeService.deletePlace(place.id);
                  if (success && mounted) {
                    setState(() {
                      _placesList = _placeService.fetchAllPlaces();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Local "${place.name}" excluído com sucesso')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Falha ao excluir o local "${place.name}"')),
                    );
                  }
                }),
          ],
        );
      },
    );
  }

  void _editPlace(BuildContext context, PlaceResponseModel place) {
    final TextEditingController _nameController =
        TextEditingController(text: place.name);
    final TextEditingController _lonController =
        TextEditingController(text: place.lon.toString());
    final TextEditingController _latController =
        TextEditingController(text: place.lat.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Local'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome do Local'),
                ),
                TextField(
                  controller: _lonController,
                  decoration: InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _latController,
                  decoration: InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () async {
                String newName = _nameController.text;
                double? newLon = double.tryParse(_lonController.text);
                double? newLat = double.tryParse(_latController.text);
                Navigator.of(context).pop();

                if (newName.isNotEmpty && newLon != null && newLat != null) {
                  PlaceRequestModel updatedPlace = PlaceRequestModel(
                    name: newName,
                    lon: newLon,
                    lat: newLat,
                  );
                  bool success =
                      await _placeService.updatePlace(place.id, updatedPlace);
                  if (success) {
                    setState(() {
                      _placesList = _placeService.fetchAllPlaces();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Local atualizado para "$newName"')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Falha ao atualizar o local')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff123c75),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Text('Locais',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder<List<PlaceResponseModel>>(
              future: _placesList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var place = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.sigeIeBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          title: Text(
                            place.name,
                            style: const TextStyle(
                                color: AppColors.lightText,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: AppColors.lightText),
                                onPressed: () => _editPlace(context, place),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: AppColors.warn),
                                onPressed: () => _confirmDelete(context, place),
                              ),
                              IconButton(
                                icon: const Icon(Icons.description,
                                    color: AppColors.lightText),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          onTap: () async {
                            List<AreaResponseModel> areasForPlace =
                                await _loadAreasForPlace(place.id);
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView.builder(
                                    itemCount: areasForPlace.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(areasForPlace[index].name),
                                      );
                                    },
                                  );
                                });
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Nenhum local encontrado."),
                  );
                }
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
