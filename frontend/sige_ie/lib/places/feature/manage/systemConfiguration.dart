import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';  

class SystemConfiguration extends StatefulWidget {
  @override
  _SystemConfigurationState createState() => _SystemConfigurationState();
}

class _SystemConfigurationState extends State<SystemConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,  // Substitua por sua cor personalizada.
        title: const Text('Local'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Quais sistemas deseja configurar?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SystemButton(title: 'Baixa Tensão', icon: Icons.flash_on),
            SystemButton(title: 'Cabeamento Estruturado', icon: Icons.settings_ethernet),
            SystemButton(title: 'Descargas Atmosféricas', icon: Icons.cloud),
            SystemButton(title: 'Alarme de Incêndio', icon: Icons.warning),
          ],
        ),
      ),
    );
  }
}

class SystemButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const SystemButton({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black),
        label: Text(title, style: const TextStyle(color: Colors.black, fontSize: 18)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow),  // Cor de fundo do botão
          foregroundColor: MaterialStateProperty.all(Colors.black),  // Cor do texto e ícone
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        onPressed: () {
          // Aqui pode-se adicionar a lógica para o que acontece ao pressionar o botão
          print('Configuring $title');
        },
      ),
    );
  }
}