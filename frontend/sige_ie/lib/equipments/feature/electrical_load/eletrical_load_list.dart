import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_service.dart';
import 'package:sige_ie/equipments/data/eletrical-load/eletrical_load_response_by_area_model.dart';
import 'package:sige_ie/equipments/feature/electrical_load/add_electrical_load.dart';

class ListElectricalLoadEquipment extends StatefulWidget {
  final String areaName;
  final String localName;
  final int systemId;
  final int localId;
  final int areaId;

  const ListElectricalLoadEquipment({
    Key? key,
    required this.areaName,
    required this.systemId,
    required this.localName,
    required this.localId,
    required this.areaId,
  }) : super(key: key);

  @override
  _ListElectricalLoadEquipmentState createState() =>
      _ListElectricalLoadEquipmentState();
}

class _ListElectricalLoadEquipmentState
    extends State<ListElectricalLoadEquipment> {
  late Future<List<EletricalLoadEquipmentResponseByAreaModel>>
      _electricalLoadList;
  final EletricalLoadEquipmentService _service =
      EletricalLoadEquipmentService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _electricalLoadList = _service.getEletricalLoadListByArea(widget.areaId);
  }

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElectricalLoadEquipmentScreen(
          areaName: widget.areaName,
          systemId: widget.systemId,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
        ),
      ),
    );
  }

  void _editEquipment(BuildContext context, int electricalLoadId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElectricalLoadEquipmentScreen(
          areaName: widget.areaName,
          systemId: widget.systemId,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
          electricalLoadId: electricalLoadId,
          isEdit: true,
        ),
      ),
    );
  }

  Future<void> _deleteEquipment(
      BuildContext context, int electricalLoadId) async {
    try {
      await _service.deleteEletricalLoad(electricalLoadId);
      setState(() {
        _electricalLoadList =
            _service.getEletricalLoadListByArea(widget.areaId);
      });
      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Equipamento deletado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Falha ao deletar o equipamento'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmDelete(BuildContext context, int electricalLoadId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text(
              'Você tem certeza que deseja excluir este equipamento?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEquipment(context, electricalLoadId);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String systemTitle = 'Cargas Elétricas';

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.sigeIeBlue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/systemLocation',
                arguments: {
                  'areaName': widget.areaName,
                  'localName': widget.localName,
                  'localId': widget.localId,
                  'areaId': widget.areaId,
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
                decoration: const BoxDecoration(
                  color: AppColors.sigeIeBlue,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    '${widget.areaName} - $systemTitle',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<EletricalLoadEquipmentResponseByAreaModel>>(
                future: _electricalLoadList,
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
                        var electricalLoad = snapshot.data![index];
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
                              electricalLoad.equipmentCategory,
                              style: const TextStyle(
                                color: AppColors.lightText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () => _editEquipment(
                                      context, electricalLoad.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _confirmDelete(
                                      context, electricalLoad.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          'Nenhum equipamento encontrado.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToAddEquipment(context),
          backgroundColor: AppColors.sigeIeYellow,
          child: const Icon(Icons.add, color: AppColors.sigeIeBlue),
        ),
      ),
    );
  }
}
