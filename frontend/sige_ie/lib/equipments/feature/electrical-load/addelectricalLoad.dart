import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageData {
  File imageFile;
  int id;
  String description;

  ImageData(this.imageFile, this.description) : id = Random().nextInt(1000000);
}

List<ImageData> _images = [];
Map<int, List<ImageData>> categoryImagesMap = {};

class AddelectricalLoadEquipmentScreen extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;

  const AddelectricalLoadEquipmentScreen({
    super.key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
  });

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddelectricalLoadEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedLocation;
  String? _selectedTypeToDelete;

  List<String> equipmentTypes = [
    'Selecione um equipamento',
    'Geladeira',
    'Ar-Condicionado',
    'Tomada(Corrente)'
  ];

  bool _shouldShowBrandAndModel() {
    return _selectedType == 'Geladeira' || _selectedType == 'Ar-Condicionado';
  }
  
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
        _showImageDialog(File(pickedFile.path));
      }
    } catch (e) {
      print('Erro ao capturar a imagem: $e');
    }
  }

  void _showImageDialog(File imageFile) {
    TextEditingController descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar descrição da imagem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(imageFile, width: 100, height: 100, fit: BoxFit.cover),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: 'Digite a descrição da imagem'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                if (descriptionController.text.isNotEmpty) {
                  setState(() {
                    final imageData = ImageData(
                      imageFile,
                      descriptionController.text,
                    );
                    final categoryNumber = widget.categoryNumber;
                    if (!categoryImagesMap.containsKey(categoryNumber)) {
                      categoryImagesMap[categoryNumber] = [];
                    }
                    categoryImagesMap[categoryNumber]!.add(imageData);
                    _images = categoryImagesMap[categoryNumber]!;
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
    if (_selectedTypeToDelete == null ||
        _selectedTypeToDelete == 'Selecione um equipamento') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Selecione um tipo de equipamento válido para excluir.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text(
              'Tem certeza de que deseja excluir o tipo de equipamento "$_selectedTypeToDelete"?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                setState(() {
                  equipmentTypes.remove(_selectedTypeToDelete);
                  _selectedTypeToDelete = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    if (_equipmentNameController.text.isEmpty ||
        _equipmentQuantityController.text.isEmpty ||
        _selectedType == null ||
        _selectedLocation == null ||
        _selectedType == 'Selecione um equipamento' ||
        _selectedLocation == 'Selecione a localização') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Dados do Equipamento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Nome:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_equipmentNameController.text),
                const SizedBox(height: 10),
                const Text('Quantidade:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_equipmentQuantityController.text),
                const SizedBox(height: 10),
                const Text('Tipo:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_selectedType ?? ''),
                const SizedBox(height: 10),
                const Text('Localização:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_selectedLocation ?? ''),
                const SizedBox(height: 10),
                const Text('Imagens:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  children: _images.map((imageData) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Image.file(
                            imageData.imageFile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(imageData.description),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Editar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                navigateToEquipmentScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToEquipmentScreen() {
    Navigator.of(context).pushNamed(
      '/equipmentScreen',
      arguments: {
        'areaName': widget.areaName,
        'localName': widget.localName,
        'localId': widget.localId,
        'categoryNumber': widget.categoryNumber,
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
                child: Text('Adicionar equipamentos ',
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
                  const Text('Tipos de equipamentos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildStyledDropdown(
                          items: equipmentTypes,
                          value: _selectedType,
                          onChanged: (newValue) {
                            if (newValue != 'Selecione um equipamento') {
                              setState(() {
                                _selectedType = newValue;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _addNewEquipmentType,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _selectedTypeToDelete = null;
                                });
                                _showDeleteDialog();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text('Marca e Modelo',
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
                  _buildStyledDropdown(
                    items: const [
                      'Selecione a localização',
                      'Interno',
                      'Externo'
                    ],
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      if (newValue != 'Selecione a localização') {
                        setState(() {
                          _selectedLocation = newValue;
                        });
                      }
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
                          if (_shouldShowBrandAndModel()) 
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
                      onPressed: _showConfirmationDialog,
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

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir tipo de equipamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione um equipamento para excluir:',
                textAlign: TextAlign.center,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: _selectedTypeToDelete,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTypeToDelete = newValue;
                  });
                },
                items: equipmentTypes
                    .where((value) => value != 'Selecione um equipamento')
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                if (_selectedTypeToDelete != null) {
                  Navigator.of(context).pop();
                  _deleteEquipmentType();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStyledDropdown({
    required List<String> items,
    String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        hint: Text(items.first),
        value: value,
        isExpanded: true,
        underline: Container(),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
            enabled: value != items.first,
          );
        }).toList(),
      ),
    );
  }
}
