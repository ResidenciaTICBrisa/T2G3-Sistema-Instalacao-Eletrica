import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class AddEquipmentScreen extends StatefulWidget {
  final String roomName;

  AddEquipmentScreen({Key? key, required this.roomName}) : super(key: key);

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedLocation;
  List<String> equipmentTypes = ['Tipo 1', 'Tipo 2', 'Tipo 3'];

  void _addNewEquipmentType() {
    // Logic to add new equipment type, perhaps a dialog input
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Adicionar Novo Tipo de Equipamento"),
          content: TextField(
            autofocus: true,
            decoration:
                const InputDecoration(hintText: "Digite o tipo de equipamento"),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  equipmentTypes.add(value);
                });
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.roomName} - Adicionar Equipamento'),
        backgroundColor: AppColors.sigeIeBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _equipmentNameController,
              decoration: const InputDecoration(
                labelText: 'Nome do equipamento',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tipo de equipamento',
              ),
              value: _selectedType,
              items: equipmentTypes.map((String type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addNewEquipmentType,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _equipmentQuantityController,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Interno ou Externo',
              ),
              value: _selectedLocation,
              items: const [
                DropdownMenuItem(value: 'Interno', child: Text('Interno')),
                DropdownMenuItem(value: 'Externo', child: Text('Externo')),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                // Logic to handle camera access
              },
            ),
          ],
        ),
      ),
    );
  }
}
