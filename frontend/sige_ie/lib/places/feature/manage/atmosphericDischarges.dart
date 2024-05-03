import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class AtmosphericDischargesScreen extends StatefulWidget {
  final String roomName;

  const AtmosphericDischargesScreen({Key? key, required this.roomName})
      : super(key: key);

  @override
  _AtmosphericDischargesScreenState createState() =>
      _AtmosphericDischargesScreenState();
}

class _AtmosphericDischargesScreenState
    extends State<AtmosphericDischargesScreen> {
  void navigateTo(String routeName) {
    Navigator.pushNamed(context, routeName);
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('${widget.roomName} - Descargas Atmosféricas',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
            ),
            OptionButton(
                title: 'ILUMINAÇÃO', onPressed: () => navigateTo('/option1')),
            OptionButton(
                title: 'CARGAS ELÉTRICAS',
                onPressed: () => navigateTo('/option2')),
            OptionButton(
                title: 'LINHAS ELÉTRICAS',
                onPressed: () => navigateTo('/option3')),
            OptionButton(
                title: 'CIRCUITOS', onPressed: () => navigateTo('/option4')),
            OptionButton(
                title: 'QUADRO DE DISTRIBUIÇÃO',
                onPressed: () => navigateTo('/option5')),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const OptionButton({
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
