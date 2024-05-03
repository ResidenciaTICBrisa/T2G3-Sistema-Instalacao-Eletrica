import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class SystemConfiguration extends StatefulWidget {
  final String roomName;

  SystemConfiguration({Key? key, required this.roomName}) : super(key: key);

  @override
  _SystemConfigurationState createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
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
            SystemButton(title: 'BAIXA TENSÃO'),
            SystemButton(title: 'CABEAMENTO ESTRUTURADO'),
            SystemButton(title: 'DESCARGAS ATMOSFÉRICAS'),
            SystemButton(title: 'ALARME DE INCÊNDIO'),
          ],
        ),
      ),
    );
  }
}

class SystemButton extends StatelessWidget {
  final String title;

  const SystemButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(title,
            style: const TextStyle(
                color: AppColors.sigeIeBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.sigeIeYellow),
          foregroundColor: MaterialStateProperty.all(AppColors.sigeIeBlue),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 25)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: () {
          // Adicione a lógica para o que acontece ao pressionar o botão
          print('Configuring $title');
        },
      ),
    );
  }
}
