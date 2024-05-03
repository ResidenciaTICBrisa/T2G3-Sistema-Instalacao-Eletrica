import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class ViewEquipmentScreen extends StatefulWidget {
  final String roomName;

  ViewEquipmentScreen({Key? key, required this.roomName}) : super(key: key);

  @override
  _ViewEquipmentScreenState createState() => _ViewEquipmentScreenState();
}

class _ViewEquipmentScreenState extends State<ViewEquipmentScreen> {
  String? _selectedEquipment;
  List<String> equipmentList = [
    'Equipamento 1',
    'Equipamento 2',
    'Equipamento 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.roomName} - Equipamentos'),
        backgroundColor: AppColors.sigeIeBlue,
      ),
      body: Center(
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Selecione um equipamento',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          value: _selectedEquipment,
          onChanged: (newValue) {
            setState(() {
              _selectedEquipment = newValue;
            });
          },
          items: equipmentList.map((String equipment) {
            return DropdownMenuItem(
              value: equipment,
              child: Text(equipment),
            );
          }).toList(),
        ),
      ),
    );
  }
}
