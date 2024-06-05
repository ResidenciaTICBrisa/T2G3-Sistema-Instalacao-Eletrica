import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/feature/cooling/coolingEquipmentList.dart';
import 'package:sige_ie/equipments/feature/distribuition-Board/distribuitionBoardEquipmentList.dart';
import 'package:sige_ie/equipments/feature/electrical-circuit/electricalCircuitList.dart';
import 'package:sige_ie/equipments/feature/electrical-line/electricaLLineLIst.dart';
import 'package:sige_ie/equipments/feature/fire-alarm/fireAlarmList.dart';
import 'package:sige_ie/equipments/feature/iluminations/IluminationEquipmentList.dart';
import 'package:sige_ie/equipments/feature/atmospheric-discharges/atmospheric-dischargesList.dart';
import 'package:sige_ie/equipments/feature/electrical-load/eletricalLoadList.dart';
import 'package:sige_ie/equipments/feature/structured-cabling/struturedCablingEquipmentList.dart';

class SystemConfiguration extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int areaId;

  const SystemConfiguration({
    super.key,
    required this.areaName,
    required this.localName,
    required this.localId,
    required this.areaId,
  });

  @override
  _SystemConfigurationState createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
  void navigateTo(String routeName, String areaName, String localName,
      int localId, int areaId, int category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (routeName) {
            case '/structuredCabling':
              return listStruturedCabling(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/atmosphericDischarges':
              return listatmosphericEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/fireAlarm':
              return listFireAlarms(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/electricLoads':
              return listelectricalLoadEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/electricLines':
              return listElectricalLineEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/circuits':
              return listCicuitEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/distributionBoard':
              return listDistribuitionBoard(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/cooling':
              return listCollingEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            case '/lighting':
              return listIluminationEquipment(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumber: category,
                areaId: areaId,
              );
            default:
              return Scaffold(
                body: Center(child: Text('No route defined for $routeName')),
              );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.sigeIeBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                child: Text(widget.areaName,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                'Quais sistemas deseja configurar?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(10.0),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: <Widget>[
                SystemIcon(
                  icon: Icons.local_fire_department,
                  label: 'ALARME DE INCÊNDIO',
                  onPressed: () => navigateTo('/fireAlarm', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 8),
                ),
                SystemIcon(
                  icon: Icons.cable,
                  label: 'CABEAMENTO ESTRUTURADO',
                  onPressed: () => navigateTo(
                      '/structuredCabling',
                      widget.areaName,
                      widget.localName,
                      widget.localId,
                      widget.areaId,
                      6),
                ),
                SystemIcon(
                  icon: Icons.electrical_services,
                  label: 'CARGAS ELÉTRICAS',
                  onPressed: () => navigateTo('/electricLoads', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 2),
                ),
                SystemIcon(
                  icon: Icons.electric_meter,
                  label: 'CIRCUITOS',
                  onPressed: () => navigateTo('/circuits', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 4),
                ),
                SystemIcon(
                  icon: Icons.bolt,
                  label: 'DESCARGAS ATMOSFÉRICAS',
                  onPressed: () => navigateTo(
                      '/atmosphericDischarges',
                      widget.areaName,
                      widget.localName,
                      widget.localId,
                      widget.areaId,
                      7),
                ),
                SystemIcon(
                  icon: Icons.lightbulb,
                  label: 'ILUMINAÇÃO',
                  onPressed: () => navigateTo('/lighting', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 1),
                ),
                SystemIcon(
                  icon: Icons.power,
                  label: 'LINHAS ELÉTRICAS',
                  onPressed: () => navigateTo('/electricLines', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 3),
                ),
                SystemIcon(
                  icon: Icons.dashboard,
                  label: 'QUADRO DE DISTRIBUIÇÃO',
                  onPressed: () => navigateTo(
                      '/distributionBoard',
                      widget.areaName,
                      widget.localName,
                      widget.localId,
                      widget.areaId,
                      5),
                ),
                SystemIcon(
                  icon: Icons.ac_unit,
                  label: 'REFRIGERAÇÃO',
                  onPressed: () => navigateTo('/cooling', widget.areaName,
                      widget.localName, widget.localId, widget.areaId, 9),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.lightText,
                      backgroundColor: AppColors.warn,
                      minimumSize: const Size(150, 50),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacementNamed(
                        context,
                        '/homeScreen',
                        arguments: {'initialPage': 1},
                      );
                    },
                    child: const Text('SAIR DA SALA'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeBlue),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.lightText),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/arealocation',
                          arguments: {
                            'placeName': widget.localName,
                            'placeId': widget.localId
                          });
                    },
                    child: const Text(
                      'CRIAR NOVA SALA',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SystemIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SystemIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.sigeIeYellow,
            ),
            child: Icon(
              icon,
              size: 40.0,
              color: AppColors.sigeIeBlue,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.sigeIeBlue,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
