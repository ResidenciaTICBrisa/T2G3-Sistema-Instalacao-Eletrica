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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: 18,
                              color: AppColors.sigeIeBlue,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text('Equipamentos',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              value: _selectedEquipment,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedEquipment = newValue;
                                });
                              },
                              items: EquipmentManager.getEquipmentList(
                                      widget.categoryNumber)
                                  .map((String equipment) {
                                return DropdownMenuItem<String>(
                                  value: equipment,
                                  child: Text(equipment,
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.left),
                                );
                              }).toList(),
                              dropdownColor: Colors.grey[200],
                              menuMaxHeight: 200,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _addNewEquipmentType();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.sigeIeYellow),
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.sigeIeBlue),
                        minimumSize:
                            MaterialStateProperty.all(const Size(165, 50)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      onPressed: () {
                        // Lógica do evento aqui
                      },
                      child: const Text('CONTINUAR'),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewEquipmentType() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController newTypeController = TextEditingController();
        return AlertDialog(
          title: const Text("Adicionar Novo Tipo de Equipamento"),
          content: TextField(
            controller: newTypeController,
            autofocus: true,
            decoration:
                const InputDecoration(hintText: "Digite o tipo de equipamento"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Adicionar"),
              onPressed: () {
                String newType = newTypeController.text;
                if (newType.isNotEmpty) {
                  setState(() {
                    // Adicione o novo tipo de equipamento à lista
                    _selectedEquipment = newType;
                  });
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }
}
