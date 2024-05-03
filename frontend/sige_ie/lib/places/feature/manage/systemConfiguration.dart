import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/feature/manage/fireAlarm.dart';
import 'package:sige_ie/places/feature/manage/lowVoltage.dart';
import 'package:sige_ie/places/feature/manage/structuredCabling.dart';
import 'atmosphericDischarges.dart';

class SystemConfiguration extends StatefulWidget {
  final String roomName;

  SystemConfiguration({Key? key, required this.roomName}) : super(key: key);

  @override
  _SystemConfigurationState createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
  void navigateTo(String routeName, String roomName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (routeName) {
            case '/lowVoltage':
              return LowVoltageScreen(roomName: roomName);
            case '/structuredCabling':
              return StructuredCablingScreen(roomName: roomName);
            case '/atmosphericDischarges':
              return AtmosphericDischargesScreen(roomName: roomName);
            case '/fireAlarm':
              return FireAlarmScreen(roomName: roomName);
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
        backgroundColor: AppColors.sigeIeBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                child: Text(widget.roomName,
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
                onPressed: () => navigateTo('/lowVoltage', widget.roomName)),
            SystemButton(
                title: 'CABEAMENTO ESTRUTURADO',
                onPressed: () =>
                    navigateTo('/structuredCabling', widget.roomName)),
            SystemButton(
                title: 'DESCARGAS ATMOSFÉRICAS',
                onPressed: () =>
                    navigateTo('/atmosphericDischarges', widget.roomName)),
            SystemButton(
                title: 'ALARME DE INCÊNDIO',
                onPressed: () => navigateTo('/fireAlarm', widget.roomName)),
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
