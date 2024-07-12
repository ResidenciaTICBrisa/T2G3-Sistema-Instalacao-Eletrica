import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/fire_alarm/fire_alarm_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/fire_alarm/fire_alarm_service.dart';
import 'package:sige_ie/equipments/feature/fire_alarm/add_fire_alarm.dart';

class ListFireAlarms extends StatefulWidget {
  final String areaName;
  final String localName;
  final int systemId;
  final int localId;
  final int areaId;

  const ListFireAlarms({
    super.key,
    required this.areaName,
    required this.systemId,
    required this.localName,
    required this.localId,
    required this.areaId,
  });

  @override
  _ListFireAlarmsState createState() => _ListFireAlarmsState();
}

class _ListFireAlarmsState extends State<ListFireAlarms> {
  late Future<List<FireAlarmEquipmentResponseByAreaModel>> _fireAlarmList;
  final FireAlarmEquipmentService _fireAlarmService =
      FireAlarmEquipmentService();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _fireAlarmList = _fireAlarmService.getFireAlarmListByArea(widget.areaId);
  }

  void navigateToAddFireAlarm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFireAlarm(
          areaName: widget.areaName,
          systemId: widget.systemId,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
          fireAlarmId: null,
        ),
      ),
    );
  }

  void _editFireAlarm(BuildContext context, int fireAlarmId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFireAlarm(
          areaName: widget.areaName,
          systemId: widget.systemId,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
          fireAlarmId: fireAlarmId,
          isEdit: true,
        ),
      ),
    );
  }

  Future<void> _deleteFireAlarm(BuildContext context, int fireAlarmId) async {
    try {
      await _fireAlarmService.deleteFireAlarm(fireAlarmId);
      setState(() {
        _fireAlarmList =
            _fireAlarmService.getFireAlarmListByArea(widget.areaId);
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

  void _confirmDelete(BuildContext context, int fireAlarmId) {
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
                _deleteFireAlarm(context, fireAlarmId);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String systemTitle = 'Alarme de Incêndio';

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
              FutureBuilder<List<FireAlarmEquipmentResponseByAreaModel>>(
                future: _fireAlarmList,
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
                        var fireAlarmEquipment = snapshot.data![index];
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
                              fireAlarmEquipment.equipmentCategory,
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
                                      _editFireAlarm(context, fireAlarmEquipment.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      _confirmDelete(context, fireAlarmEquipment.id),
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
                              color: Colors.black54),
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
          onPressed: () => navigateToAddFireAlarm(context),
          backgroundColor: AppColors.sigeIeYellow,
          child: const Icon(Icons.add, color: AppColors.sigeIeBlue),
        ),
      ),
    );
  }
}
