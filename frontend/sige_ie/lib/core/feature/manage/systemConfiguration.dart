import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/core/feature/manage/EquipmentScreen.dart';
import 'package:sige_ie/core/feature/manage/lowVoltage.dart';

class SystemConfiguration extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;

  SystemConfiguration({
    Key? key,
    required this.areaName,
    required this.localName,
    required this.localId,
    required this.categoryNumber,
  }) : super(key: key);

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
            case '/lowVoltage':
              return LowVoltageScreen(
                areaName: areaName,
                localName: localName,
                localId: localId,
                categoryNumbers: category,
              );
            case '/structuredCabling':
            case '/atmosphericDischarges':
            case '/fireAlarm':
              return EquipmentScreen(
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
              padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text(widget.areaName,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: const Text(
                'Quais sistemas deseja configurar?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SystemButton(
                title: 'BAIXA TENSÃO',
                onPressed: () => navigateTo('/lowVoltage', widget.areaName,
                    widget.localName, widget.localId, [1, 2, 3, 4, 5])),
            SystemButton(
                title: 'CABEAMENTO ESTRUTURADO',
                onPressed: () => navigateTo('/structuredCabling',
                    widget.areaName, widget.localName, widget.localId, 6)),
            SystemButton(
                title: 'DESCARGAS ATMOSFÉRICAS',
                onPressed: () => navigateTo('/atmosphericDischarges',
                    widget.areaName, widget.localName, widget.localId, 7)),
            SystemButton(
                title: 'ALARME DE INCÊNDIO',
                onPressed: () => navigateTo('/fireAlarm', widget.areaName,
                    widget.localName, widget.localId, 8)),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.warn),
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.lightText),
                  minimumSize: MaterialStateProperty.all(const Size(175, 55)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/arealocation', arguments: {
                    'placeName': widget.localName,
                    'placeId': widget.localId
                  });
                },
                child: const Text(
                  'ENCERRAR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
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
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(title,
            style: const TextStyle(
                color: AppColors.sigeIeBlue,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
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
      ),
    );
  }
}
