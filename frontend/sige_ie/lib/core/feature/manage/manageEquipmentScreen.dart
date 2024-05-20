import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/core/feature/manage/EquipmentScreen.dart';

class ViewEquipmentScreen extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;

  const ViewEquipmentScreen(
      {super.key,
      required this.areaName,
      required this.categoryNumber,
      required this.localName,
      required this.localId});

  @override
  _ViewEquipmentScreenState createState() => _ViewEquipmentScreenState();
}

class _ViewEquipmentScreenState extends State<ViewEquipmentScreen> {
  String? _selectedEquipment;
  List<String> equipmentList = [
    'Eletroduto',
    'Eletrocalha',
    'Dimensão',
    'Para-raios',
    'Captação',
    'Subsistemas',
    'Alarme de incêndio',
    'Sensor de fumaça'
  ];

  void navigateToEquipmentScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EquipmentScreen(
        areaName: widget.areaName,
        categoryNumber: widget.categoryNumber,
        localName: widget.localName,
        localId: widget.localId,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (equipmentList.isNotEmpty) {
      _selectedEquipment = _selectedEquipment ?? equipmentList.first;
    }
  }

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
                child: Text(
                  'Gerenciar equipamentos',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Equipamentos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedEquipment,
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedEquipment = newValue;
                          });
                        },
                        items: equipmentList.map((String equipment) {
                          return DropdownMenuItem<String>(
                            value: equipment,
                            child: Text(equipment,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        dropdownColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.sigeIeYellow),
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.sigeIeBlue),
                          minimumSize:
                              MaterialStateProperty.all(const Size(175, 55)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: navigateToEquipmentScreen,
                        child: const Text(
                          'SALVAR',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
