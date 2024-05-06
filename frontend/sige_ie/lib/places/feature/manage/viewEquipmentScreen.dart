import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/feature/manage/equipment_manager.dart';

class ViewEquipmentScreen extends StatefulWidget {
  final String roomName;
  final int categoryNumber;

  ViewEquipmentScreen(
      {Key? key, required this.roomName, required this.categoryNumber})
      : super(key: key);

  @override
  _ViewEquipmentScreenState createState() => _ViewEquipmentScreenState();
}

class _ViewEquipmentScreenState extends State<ViewEquipmentScreen> {
  String? _selectedEquipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categoria: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          EquipmentManager.categoryMap[widget.categoryNumber]!,
                          style: TextStyle(
                              fontSize: 18, color: AppColors.sigeIeBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Selecione um equipamento',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedEquipment,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedEquipment = newValue;
                      });
                    },
                    items:
                        EquipmentManager.getEquipmentList(widget.categoryNumber)
                            .map((String equipment) {
                      return DropdownMenuItem<String>(
                        value: equipment,
                        child: Text(equipment),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeYellow),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeBlue),
                      minimumSize:
                          MaterialStateProperty.all(const Size(165, 50)),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Lógica do evento aqui
                    },
                    child: const Text('CONTINUAR'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
