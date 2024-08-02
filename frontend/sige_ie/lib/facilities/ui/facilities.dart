import 'package:flutter/material.dart';
import 'package:sige_ie/areas/data/area_request_model.dart';
import 'package:sige_ie/areas/data/area_response_model.dart';
import 'package:sige_ie/core/data/universalURL.dart';
import 'package:sige_ie/places/data/place_request_model.dart';
import 'package:sige_ie/places/data/place_response_model.dart';
import 'package:sige_ie/places/data/place_service.dart';
import '../../config/app_styles.dart';
import '../../areas/data/area_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  @override
  _FacilitiesPageState createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  late Future<List<PlaceResponseModel>> _placesList;
  final PlaceService _placeService = PlaceService();
  final AreaService _areaService = AreaService();
  late BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    _placesList = _placeService.fetchAllPlaces();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldContext = context;
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
                                      ScaffoldMessenger.of(_scaffoldContext)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Área atualizada com sucesso')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(_scaffoldContext)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Falha ao atualizar a área')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(_scaffoldContext)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Dados inválidos para a área')),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                        SnackBar(content: Text('Erro ao editar a área: $e')),
                      );
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
                        ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text('Área excluída com sucesso')),
                        );
                      } else {
                        ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text('Erro ao excluir a área')),
                        );
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
      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
        SnackBar(content: Text('Erro ao carregar as áreas: $e')),
      );
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
                if (success) {
                  if (mounted) {
                    setState(() {
                      _placesList = _placeService.fetchAllPlaces();
                    });
                    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Local "${place.name}" excluído com sucesso')),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                      SnackBar(
                          content:
                              Text('Falha ao excluir o local "${place.name}"')),
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

  void _editPlace(BuildContext context, PlaceResponseModel place) {
    final TextEditingController nameController =
        TextEditingController(text: place.name);
    final TextEditingController lonController =
        TextEditingController(text: place.lon.toString());
    final TextEditingController latController =
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
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nome do Local'),
                ),
                TextField(
                  controller: lonController,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: latController,
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
                String newName = nameController.text;
                double? newLon = double.tryParse(lonController.text);
                double? newLat = double.tryParse(latController.text);
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
                    if (mounted) {
                      setState(() {
                        _placesList = _placeService.fetchAllPlaces();
                      });
                      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                        SnackBar(
                            content: Text('Local atualizado para "$newName"')),
                      );
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                        const SnackBar(
                            content: Text('Falha ao atualizar o local')),
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

  Future<void> _exportToPDF(int placeId) async {
    final response =
        await http.get(Uri.parse('$urlUniversal/api/places/$placeId/report'));

    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, 'report_$placeId.pdf');
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
        SnackBar(content: Text('PDF baixado com sucesso: $filePath')),
      );
    } else {
      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
        const SnackBar(content: Text('Falha ao baixar o PDF')),
      );
    }
  }

  void _exportToExcel(int placeId) {
    // Implement your Excel export logic here
    print("Export to Excel for place $placeId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff123c75),
        elevation: 0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: const BoxDecoration(
                    color: AppColors.sigeIeBlue,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text('Edificações',
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
                                        color: Colors.blue),
                                    onPressed: () =>
                                        _editPlace(_scaffoldContext, place),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _confirmDelete(_scaffoldContext, place),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: const Icon(Icons.description,
                                        color: AppColors.lightText),
                                    onSelected: (value) {
                                      if (value == 'pdf') {
                                        _exportToPDF(place.id);
                                      } else if (value == 'excel') {
                                        _exportToExcel(place.id);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'pdf',
                                        child: Text('Exportar para PDF'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'excel',
                                        child: Text('Exportar para Excel'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () =>
                                  _showAreasForPlace(_scaffoldContext, place),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Nenhum local encontrado.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
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

  const FloorAreaWidget({
    super.key,
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
          child: groupedAreas.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Você ainda não tem uma sala neste local.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                )
              : ListView(
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
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => onEditArea(area.id),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
          leading: const Icon(Icons.add),
          title: const Text('Adicionar sala'),
          onTap: onAddFloor,
        ),
      ],
    );
  }
}
