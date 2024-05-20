import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageData {
  File imageFile;
  int id;

  ImageData(this.imageFile) : id = Random().nextInt(1000000);
}

List<ImageData> _images = [];
Map<int, List<ImageData>> categoryImagesMap = {};

class AddEquipmentScreen extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;

  const AddEquipmentScreen({
    super.key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
  });

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedLocation;

  List<String> equipmentTypes = ['Eletroduto', 'Eletrocalha', 'Dimensão'];

  @override
  void dispose() {
    _equipmentNameController.dispose();
    _equipmentQuantityController.dispose();
    categoryImagesMap[widget.categoryNumber]?.clear();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          final imageData = ImageData(File(pickedFile.path));
          final categoryNumber = widget.categoryNumber;
          if (!categoryImagesMap.containsKey(categoryNumber)) {
            categoryImagesMap[categoryNumber] = [];
          }
          categoryImagesMap[categoryNumber]!.add(imageData);
          _images = categoryImagesMap[categoryNumber]!;
        });
      }
    } catch (e) {
      print('Erro ao capturar a imagem: $e');
    }
  }

  void _addNewEquipmentType() {
    TextEditingController typeController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar novo tipo de equipamento'),
          content: TextField(
            controller: typeController,
            decoration: const InputDecoration(
                hintText: 'Digite o novo tipo de equipamento'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (typeController.text.isNotEmpty) {
                  setState(() {
                    equipmentTypes.add(typeController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEquipmentType() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir tipo de equipamento'),
          content: DropdownButton<String>(
            value: _selectedType,
            onChanged: (String? newValue) {
              setState(() {
                equipmentTypes.remove(newValue);
                _selectedType =
                    equipmentTypes.isNotEmpty ? equipmentTypes.first : null;
              });
              Navigator.of(context).pop();
            },
            items: equipmentTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                child: Text('Equipamentos na sala',
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
                    children: [
                      Expanded(
                        child: _buildDropdown(
                          items: equipmentTypes,
                          value: _selectedType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedType = newValue;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addNewEquipmentType,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: _deleteEquipmentType,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text('Nome do equipamento',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _equipmentNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Quantidade',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _equipmentQuantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Localização (Interno ou Externo)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                    onPressed: _pickImage,
                  ),
                  Wrap(
                    children: _images.map((imageData) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              imageData.imageFile,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: AppColors.warn),
                            onPressed: () {
                              setState(() {
                                _images.removeWhere(
                                    (element) => element.id == imageData.id);
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
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
                              MaterialStateProperty.all(const Size(185, 55)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () {
                        // Implementar a lógica de adicionar equipamento
                      },
                      child: const Text(
                        'ADICIONAR EQUIPAMENTO',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
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
    String? value,
    required Function(String?) onChanged,
  }) {
    String dropdownValue = value ?? items.first;
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
