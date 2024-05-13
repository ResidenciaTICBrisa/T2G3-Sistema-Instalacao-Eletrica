import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/core/feature/manage/addEquipmentScreen.dart';
import 'package:sige_ie/core/feature/manage/manageEquipmentScreen.dart';

class EquipmentScreen extends StatelessWidget {
  final String areaName;
  final String localName;
  final int categoryNumber;
  final int localId;

  EquipmentScreen({
    Key? key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
  }) : super(key: key);

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEquipmentScreen(
          areaName: areaName,
          categoryNumber: categoryNumber,
          localName: localName,
          localId: localId,
        ),
      ),
    );
  }

  void navigateToViewEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewEquipmentScreen(
          areaName: areaName,
          categoryNumber: categoryNumber,
          localName: localName,
          localId: localId,
        ),
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
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/systemLocation',
              arguments: {
                'areaName': areaName,
                'localName': localName,
                'localId': localId,
                'categoryNumber': categoryNumber,
              },
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
            decoration: BoxDecoration(
              color: AppColors.sigeIeBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Center(
              child: Text(areaName,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightText)),
            ),
          ),
          SizedBox(height: 150),
          EquipmentButton(
            title: 'EQUIPAMENTOS NA SALA',
            onPressed: () => navigateToAddEquipment(context),
          ),
          EquipmentButton(
            title: 'GERENCIAR EQUIPAMENTOS',
            onPressed: () => navigateToViewEquipment(context),
          ),
        ],
      ),
    );
  }
}

class EquipmentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  EquipmentButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: ElevatedButton(
        child: Text(title,
            style: const TextStyle(
                color: AppColors.sigeIeBlue,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.sigeIeYellow),
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
