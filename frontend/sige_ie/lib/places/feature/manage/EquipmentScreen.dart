import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/feature/manage/addEquipmentScreen.dart';
import 'package:sige_ie/places/feature/manage/viewEquipmentScreen.dart';

class EquipmentScreen extends StatelessWidget {
  final String roomName;

  EquipmentScreen({Key? key, required this.roomName}) : super(key: key);

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEquipmentScreen(roomName: roomName),
      ),
    );
  }

  void navigateToViewEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewEquipmentScreen(roomName: roomName),
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
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretches horizontally
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
            decoration: BoxDecoration(
              color: AppColors.sigeIeBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Center(
              child: Text('${roomName}',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightText)),
            ),
          ),
          SizedBox(height: 150), // Define the height for spacing as needed
          EquipmentButton(
            title: 'ADICIONAR EQUIPAMENTOS',
            onPressed: () => navigateToAddEquipment(context),
          ),
          EquipmentButton(
            title: 'VER EQUIPAMENTOS',
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
                color: AppColors.sigeIeYellow,
                fontSize: 18,
                fontWeight: FontWeight.w900)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.sigeIeBlue),
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
