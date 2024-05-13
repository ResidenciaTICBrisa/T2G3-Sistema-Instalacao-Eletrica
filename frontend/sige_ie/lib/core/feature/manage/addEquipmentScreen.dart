import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/core/feature/manage/equipment_manager.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

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

  AddEquipmentScreen({
    Key? key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
  }) : super(key: key);

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedLocation;
  List<String> equipmentTypes = [];

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

  @override
  void initState() {
    super.initState();
    equipmentTypes = EquipmentManager.getEquipmentList(widget.categoryNumber);
    _images = categoryImagesMap[widget.categoryNumber] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _equipmentNameController.clear();
          _equipmentQuantityController.clear();
          categoryImagesMap[widget.categoryNumber]?.clear();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.sigeIeBlue,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _equipmentNameController.clear();
                _equipmentQuantityController.clear();
                categoryImagesMap[widget.categoryNumber]?.clear();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categoria: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              EquipmentManager
                                  .categoryMap[widget.categoryNumber]!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.sigeIeBlue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Equipamentos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        items: equipmentTypes,
                        value: _selectedType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text('Nome do equipamento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text('Quantidade',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _equipmentQuantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text('Localização (Interno ou Externo)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
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
                                    _images.removeWhere((element) =>
                                        element.id == imageData.id);
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
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.sigeIeYellow),
                              foregroundColor: MaterialStateProperty.all(
                                  AppColors.sigeIeBlue),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(185, 55)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {
                            Navigator.pushNamed(context, '/systemLocation',
                                arguments: {
                                  'areaName': widget.areaName,
                                  'localName': widget.localName,
                                  'localId': widget.localId,
                                  'categoryNumber': widget.categoryNumber,
                                });
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
        ));
  }

  Widget _buildDropdown({
    required List<String> items,
    String? value,
    required Function(String?) onChanged,
  }) {
    String dropdownValue = value ?? 'Escolha um...';
    List<String> dropdownItems = ['Escolha um...'] + items;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          iconSize: 30,
          iconEnabledColor: AppColors.sigeIeBlue,
          isExpanded: true,
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != 'Escolha um...') {
              onChanged(newValue);
            }
          },
          hint: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text('Selecione uma opção'),
          ),
        ),
      ),
    );
  }
}
