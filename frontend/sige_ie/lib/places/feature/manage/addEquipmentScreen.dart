import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/feature/manage/equipment_manager.dart'; // Certifique-se de que este import esteja correto para seu projeto
import 'dart:io';
import 'package:image_picker/image_picker.dart';

File? _image;

class AddEquipmentScreen extends StatefulWidget {
  final String roomName;
  final int categoryNumber;

  AddEquipmentScreen(
      {Key? key, required this.roomName, required this.categoryNumber})
      : super(key: key);

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedLocation;
  List<String> equipmentTypes = []; // A lista agora é inicializada vazia
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erro ao capturar a imagem: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Carrega os tipos de equipamento com base na categoria selecionada ao iniciar a tela
    equipmentTypes = EquipmentManager.getEquipmentList(widget.categoryNumber);
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
                    equipmentTypes.add(newType);
                    // Opcionalmente, pode-se definir o novo tipo como o selecionado
                    _selectedType = newType;
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
                child: Text('Registrar Novo Equipamento',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
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
                  const SizedBox(height: 15),
                  const Text('Equipamento',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    items: equipmentTypes,
                    value: _selectedType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                    addNew: _addNewEquipmentType,
                    showAddButton: true, // Ative o botão de adição
                  ),
                  const SizedBox(height: 30),
                  const Text('Nome do equipamento',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _equipmentNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Quantidade',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _equipmentQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Localização (Interno ou Externo)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    items: const ['Interno', 'Externo'],
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed:
                        _pickImage, // Atualiza aqui para chamar _pickImage quando clicado
                  ),
                  const SizedBox(height: 15),
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
                        // Lógica de evento aqui
                      },
                      child: const Text('CONTINUAR'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
    VoidCallback? addNew,
    bool showAddButton = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                ),
                value: value,
                isExpanded: true,
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.grey[200],
              ),
            ),
          ),
        ),
        if (showAddButton)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addNew,
          ),
      ],
    );
  }
}
