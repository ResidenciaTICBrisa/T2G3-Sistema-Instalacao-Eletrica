import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/feature/electrical-line/electricaLLineLIst.dart';
import 'package:sige_ie/equipments/feature/iluminations/IluminationEquipmentList.dart';
import 'package:sige_ie/equipments/feature/atmospheric-discharges/atmospheric-dischargesList.dart';
import 'package:sige_ie/equipments/feature/electrical-load/eletricalLoadList.dart';

class SystemConfiguration extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;

  const SystemConfiguration({
    super.key,
    required this.areaName,
    required this.localName,
    required this.localId,
    required this.categoryNumber,
  });

  @override
  _SystemConfigurationState createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
  void navigateTo(String routeName, String areaName, String localName,
      int localId, dynamic category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (routeName) {
            case '/structuredCabling':
            case '/atmosphericDischarges':
              return listatmosphericEquipment(
                  areaName: areaName,
                  localName: localName,
                  localId: localId,
                  categoryNumber: category);
            case '/fireAlarm':
            case '/electricLoads':
              return listelectricalLoadEquipment(
                  areaName: areaName,
                  localName: localName,
                  localId: localId,
                  categoryNumber: category);
            case '/electricLines':
              return listElectricalLineEquipment(
                  areaName: areaName,
                  localName: localName,
                  localId: localId,
                  categoryNumber: category);
            case '/circuits':
            case '/distributionBoard':
            case '/cooling':
            //return EquipmentScreen(
            //  areaName: areaName,
            //localName: localName,
            //localId: localId,
            //categoryNumber: category);
            case '/lighting':
              return listIluminationEquipment(
                  areaName: areaName,
                  localName: localName,
                  localId: localId,
                  categoryNumber: category);
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
            SystemButton(
                title: 'ALARME DE INCÊNDIO',
                onPressed: () => navigateTo('/fireAlarm', widget.areaName,
                    widget.localName, widget.localId, 8)),
            SystemButton(
                title: 'CABEAMENTO ESTRUTURADO',
                onPressed: () => navigateTo('/structuredCabling',
                    widget.areaName, widget.localName, widget.localId, 6)),
            SystemButton(
                title: 'CARGAS ELÉTRICAS',
                onPressed: () => navigateTo('/electricLoads', widget.areaName,
                    widget.localName, widget.localId, 2)),
            SystemButton(
                title: 'CIRCUITOS',
                onPressed: () => navigateTo('/circuits', widget.areaName,
                    widget.localName, widget.localId, 4)),
            SystemButton(
                title: 'DESCARGAS ATMOSFÉRICAS',
                onPressed: () => navigateTo('/atmosphericDischarges',
                    widget.areaName, widget.localName, widget.localId, 7)),
            SystemButton(
                title: 'ILUMINAÇÃO',
                onPressed: () => navigateTo('/lighting', widget.areaName,
                    widget.localName, widget.localId, 1)),
            SystemButton(
                title: 'LINHAS ELÉTRICAS',
                onPressed: () => navigateTo('/electricLines', widget.areaName,
                    widget.localName, widget.localId, 3)),
            SystemButton(
                title: 'QUADRO DE DISTRIBUIÇÃO',
                onPressed: () => navigateTo('/distributionBoard',
                    widget.areaName, widget.localName, widget.localId, 5)),
            SystemButton(
                title: 'REFRIGERAÇÃO',
                onPressed: () => navigateTo('/cooling', widget.areaName,
                    widget.localName, widget.localId, 9)),
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

class SystemButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SystemButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.sigeIeYellow),
          foregroundColor: MaterialStateProperty.all(AppColors.sigeIeBlue),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 25)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: const TextStyle(
                color: AppColors.sigeIeBlue,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
      ),
    );
  }
}
