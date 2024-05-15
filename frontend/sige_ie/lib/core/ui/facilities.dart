import 'package:flutter/material.dart';
import 'package:sige_ie/areas/data/area_request_model.dart';
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

  Map<int, List<AreaResponseModel>> _groupAreasByFloor(
      List<AreaResponseModel> areas) {
    Map<int, List<AreaResponseModel>> groupedAreas = {};
    for (var area in areas) {
      if (groupedAreas[area.floor ?? 0] == null) {
        groupedAreas[area.floor ?? 0] = [];
      }
      groupedAreas[area.floor ?? 0]!.add(area);
    }
    return groupedAreas;
  }

  Future<void> _showAreasForPlace(
      BuildContext context, PlaceResponseModel place) async {
    try {
      List<AreaResponseModel> areasForPlace =
          await _areaService.fetchAreasByPlaceId(place.id);
      Map<int, List<AreaResponseModel>> groupedAreas =
          _groupAreasByFloor(areasForPlace);

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter modalSetState) {
              return FloorAreaWidget(
                  groupedAreas: groupedAreas,
                  placeName: place.name,
                  placeId: place.id,
                  onAddFloor: () {
                    Navigator.of(context)
                        .pushNamed('/arealocation', arguments: {
                      'placeName': place.name,
                      'placeId': place.id,
                    });
                  },
                  onEditArea: (int areaId) async {
                    try {
                      AreaResponseModel area =
                          await _areaService.fetchArea(areaId);
                      TextEditingController nameController =
                          TextEditingController(text: area.name);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Editar Área'),
                            content: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Nome da Área'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Salvar'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  if (area.floor != null) {
                                    AreaRequestModel updatedArea =
                                        AreaRequestModel(
                                      name: nameController.text,
                                      floor: area.floor!,
                                      place: area.place,
                                    );

                                    bool success = await _areaService
                                        .updateArea(areaId, updatedArea);
                                    if (success) {
                                      modalSetState(() {
                                        groupedAreas[area.floor ?? -1] =
                                            groupedAreas[area.floor ?? -1]!
                                                .map((a) => a.id == areaId
                                                    ? AreaResponseModel(
                                                        id: area.id,
                                                        name: updatedArea.name,
                                                        floor:
                                                            updatedArea.floor ??
                                                                -1,
                                                        place:
                                                            updatedArea.place ??
                                                                -1,
                                                      )
                                                    : a)
                                                .toList();
                                      });
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Área atualizada com sucesso')),
                                        );
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Falha ao atualizar a área')),
                                        );
                                      }
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Dados inválidos para a área')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao editar a área: $e')),
                        );
                      }
                    }
                  },
                  onDeleteArea: (int areaId) async {
                    bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Confirmar Exclusão'),
                          content:
                              const Text('Realmente deseja excluir esta área?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(dialogContext).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Excluir'),
                              onPressed: () {
                                Navigator.of(dialogContext).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmDelete) {
                      bool success = await _areaService.deleteArea(areaId);
                      if (success) {
                        modalSetState(() {
                          groupedAreas.forEach((key, value) {
                            value.removeWhere((a) => a.id == areaId);
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Área excluída com sucesso')),
                        );
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Erro ao excluir a área')),
                          );
                        }
                      }
                    }
                  },
                  onTapArea: (int areaId) async {
                    AreaResponseModel area =
                        await _areaService.fetchArea(areaId);
                    Navigator.pushNamed(context, '/systemLocation', arguments: {
                      'areaName': area.name,
                      'localName': place.name,
                      'localId': place.id,
                      'areaId': area.id,
                    });
                  });
            },
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar as áreas: $e')),
        );
      }
    }
  }

  void _confirmDelete(BuildContext context, PlaceResponseModel place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content:
              Text('Você realmente deseja excluir o local "${place.name}"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                Navigator.of(context).pop();
                bool success = await _placeService.deletePlace(place.id);
                if (success && mounted) {
                  setState(() {
                    _placesList = _placeService.fetchAllPlaces();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Local "${place.name}" excluído com sucesso')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Falha ao excluir o local "${place.name}"')),
                  );
                }
              },
            ),
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
          title: const Text('Editar Local'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome do Local'),
                ),
                TextField(
                  controller: _lonController,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _latController,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
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
                  if (success && mounted) {
                    setState(() {
                      _placesList = _placeService.fetchAllPlaces();
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Local atualizado para "$newName"')),
                      );
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Falha ao atualizar o local')),
                      );
                    }
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
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editPlace(context, place),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(context, place),
                              ),
                              IconButton(
                                icon: const Icon(Icons.description,
                                    color: AppColors.lightText),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          onTap: () => _showAreasForPlace(context, place),
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

class FloorAreaWidget extends StatelessWidget {
  final Map<int, List<AreaResponseModel>> groupedAreas;
  final String placeName;
  final int placeId;
  final VoidCallback onAddFloor;
  final Function(int) onEditArea;
  final Function(int) onDeleteArea;
  final Function(int) onTapArea;

  FloorAreaWidget({
    required this.groupedAreas,
    required this.placeName,
    required this.placeId,
    required this.onAddFloor,
    required this.onEditArea,
    required this.onDeleteArea,
    required this.onTapArea,
  });

  @override
  Widget build(BuildContext context) {
    var sortedKeys = groupedAreas.keys.toList()..sort();
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: sortedKeys.map((floor) {
              List<AreaResponseModel> areas = groupedAreas[floor]!;
              String floorName = floor == 0 ? "Térreo" : "$floor° andar";
              return ExpansionTile(
                title: Text(floorName),
                children: areas.map((area) {
                  return ListTile(
                    title: Text(area.name),
                    onTap: () => onTapArea(area.id),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => onEditArea(area.id),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onDeleteArea(area.id),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Adicionar andar ou sala'),
          onTap: onAddFloor,
        ),
      ],
    );
  }
}
