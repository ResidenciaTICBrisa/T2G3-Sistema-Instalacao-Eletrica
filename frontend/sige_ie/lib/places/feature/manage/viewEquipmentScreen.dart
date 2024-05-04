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
        backgroundColor: AppColors.sigeIeBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Text('Visualizar Equipamentos',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Center(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Selecione um equipamento',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  SizedBox(height: 150),
                  Center(
                    child: ElevatedButton(
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
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
