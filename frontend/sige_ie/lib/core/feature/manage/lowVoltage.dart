import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/core/feature/manage/EquipmentScreen.dart';

class LowVoltageScreen extends StatefulWidget {
  final String areaName;
  final List<int> categoryNumbers;
  final String localName;
  final int? localId;

  const LowVoltageScreen({
    super.key,
    required this.areaName,
    required this.categoryNumbers,
    required this.localName,
    this.localId,
  });

  @override
  _LowVoltageScreenState createState() => _LowVoltageScreenState();
}

class _LowVoltageScreenState extends State<LowVoltageScreen> {
  void navigateToEquipmentScreen(int categoryNumber) {
    if (widget.localId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EquipmentScreen(
            areaName: widget.areaName,
            localName: widget.localName,
            localId: widget.localId!,
            categoryNumber: categoryNumber,
          ),
        ),
      );
    }
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
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('${widget.areaName} - Baixa Tensão',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            const Padding(padding: EdgeInsets.all(15.0)),
            OptionButton(
                title: 'ILUMINAÇÃO',
                onPressed: () =>
                    navigateToEquipmentScreen(widget.categoryNumbers[0])),
            OptionButton(
                title: 'CARGAS ELÉTRICAS',
                onPressed: () =>
                    navigateToEquipmentScreen(widget.categoryNumbers[1])),
            OptionButton(
                title: 'LINHAS ELÉTRICAS',
                onPressed: () =>
                    navigateToEquipmentScreen(widget.categoryNumbers[2])),
            OptionButton(
                title: 'CIRCUITOS',
                onPressed: () =>
                    navigateToEquipmentScreen(widget.categoryNumbers[3])),
            OptionButton(
                title: 'QUADRO DE DISTRIBUIÇÃO',
                onPressed: () =>
                    navigateToEquipmentScreen(widget.categoryNumbers[4])),
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
