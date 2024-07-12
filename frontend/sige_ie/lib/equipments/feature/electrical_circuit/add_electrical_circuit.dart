import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_request_model.dart';
import 'package:sige_ie/equipments/data/equipment_service.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_request_model.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_service.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_response_model.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_service.dart';
import 'package:sige_ie/shared/data/personal-equipment-category/personal_equipment_category_request_model.dart';
import 'package:sige_ie/shared/data/personal-equipment-category/personal_equipment_category_service.dart';

class ImageData {
  File imageFile;
  int id;
  String description;

  ImageData(this.imageFile, this.description) : id = Random().nextInt(1000000);
}

List<ImageData> _images = [];
Map<int, List<ImageData>> categoryImagesMap = {};

class AddElectricalCircuitEquipmentScreen extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int systemId;
  final int areaId;

  const AddElectricalCircuitEquipmentScreen({
    super.key,
    required this.areaName,
    required this.systemId,
    required this.localName,
    required this.localId,
    required this.areaId,
  });

  @override
  _AddElectricalCircuitEquipmentScreenState createState() =>
      _AddElectricalCircuitEquipmentScreenState();
}

class _AddElectricalCircuitEquipmentScreenState
    extends State<AddElectricalCircuitEquipmentScreen> {
  EquipmentService equipmentService = EquipmentService();
  EquipmentPhotoService equipmentPhotoService = EquipmentPhotoService();
  PersonalEquipmentCategoryService personalEquipmentCategoryService =
      PersonalEquipmentCategoryService();
  GenericEquipmentCategoryService genericEquipmentCategoryService =
      GenericEquipmentCategoryService();

  final _equipmentQuantityController = TextEditingController();
  final _breakerLocationController = TextEditingController();
  final _breakerStateController = TextEditingController();
  final _wireTypeController = TextEditingController();
  final _dimensionController = TextEditingController();
  String? _selectedTypeToDelete;
  String? _selectCircuitType;
  String? _newEquipmentTypeName;
  int? _selectedGenericEquipmentCategoryId;
  int? _selectedPersonalEquipmentCategoryId;
  bool _isPersonalEquipmentCategorySelected = false;

  List<Map<String, Object>> genericEquipmentTypes = [];
  List<Map<String, Object>> personalEquipmentTypes = [];
  Map<String, int> personalEquipmentMap = {};

  @override
  void initState() {
    super.initState();
    _fetchEquipmentCategory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchEquipmentCategory();
  }

  Future<void> _fetchEquipmentCategory() async {
    List<EquipmentCategoryResponseModel> genericEquipmentCategoryList =
        await genericEquipmentCategoryService
            .getAllGenericEquipmentCategoryBySystem(widget.systemId);

    List<EquipmentCategoryResponseModel> personalEquipmentCategoryList =
        await personalEquipmentCategoryService
            .getAllPersonalEquipmentCategoryBySystem(widget.systemId);

    if (mounted) {
      setState(() {
        genericEquipmentTypes = genericEquipmentCategoryList
            .map((e) => {'id': e.id, 'name': e.name, 'type': 'generico'})
            .toList();
        personalEquipmentTypes = personalEquipmentCategoryList
            .map((e) => {'id': e.id, 'name': e.name, 'type': 'pessoal'})
            .toList();
        personalEquipmentMap = {
          for (var equipment in personalEquipmentCategoryList)
            equipment.name: equipment.id
        };
      });
    }
  }

  @override
  void dispose() {
    _equipmentQuantityController.dispose();
    _breakerLocationController.dispose();
    _breakerStateController.dispose();
    _wireTypeController.dispose();
    _dimensionController.dispose();
    categoryImagesMap[widget.systemId]?.clear();
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

  void _showImageDialog(File imageFile, {ImageData? existingImage}) {
    TextEditingController descriptionController =
        TextEditingController(text: existingImage?.description ?? '');
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
                    hintText: 'Digite a descrição da imagem (opcional)'),
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
                setState(() {
                  if (existingImage != null) {
                    existingImage.description = descriptionController.text;
                  } else {
                    final imageData =
                        ImageData(imageFile, descriptionController.text);
                    final systemId = widget.systemId;
                    if (!categoryImagesMap.containsKey(systemId)) {
                      categoryImagesMap[systemId] = [];
                    }
                    categoryImagesMap[systemId]!.add(imageData);
                    _images = categoryImagesMap[systemId]!;
                  }
                });
                Navigator.of(context).pop();
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
          title: const Text('Adicionar novo tipo de Circuito Elétrico'),
          content: TextField(
            controller: typeController,
            decoration: const InputDecoration(
                hintText: 'Digite o novo tipo de Circuito Elétrico'),
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
                    _newEquipmentTypeName = typeController.text;
                  });
                  _registerPersonalEquipmentType().then((_) {
                    setState(() {
                      _selectCircuitType = null;
                      _selectedGenericEquipmentCategoryId = null;
                      _fetchEquipmentCategory();
                    });
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

  Future<void> _registerPersonalEquipmentType() async {
    int systemId = widget.systemId;
    PersonalEquipmentCategoryRequestModel personalEquipmentTypeRequestModel =
        PersonalEquipmentCategoryRequestModel(
            name: _newEquipmentTypeName ?? '', system: systemId);

    int id = await personalEquipmentCategoryService
        .createPersonalEquipmentCategory(personalEquipmentTypeRequestModel);

    if (id != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Equipamento registrado com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        personalEquipmentTypes
            .add({'name': _newEquipmentTypeName!, 'id': id, 'type': 'pessoal'});
        personalEquipmentMap[_newEquipmentTypeName!] = id;
        _newEquipmentTypeName = null;
        _fetchEquipmentCategory();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao registrar o equipamento.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteEquipmentType() async {
    if (personalEquipmentTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Não existem categorias de equipamentos a serem excluídas.'),
        ),
      );
      return;
    }

    if (_selectedTypeToDelete == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Selecione uma categoria de equipamento válida para excluir.'),
        ),
      );
      return;
    }

    int equipmentId = personalEquipmentMap[_selectedTypeToDelete]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content:
              const Text('Tem certeza de que deseja excluir este equipamento?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                Navigator.of(context).pop();
                bool success = await personalEquipmentCategoryService
                    .deletePersonalEquipmentCategory(equipmentId);

                if (success) {
                  setState(() {
                    personalEquipmentTypes.removeWhere(
                        (element) => element['name'] == _selectedTypeToDelete);
                    _selectedTypeToDelete = null;
                    _fetchEquipmentCategory();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Equipamento excluído com sucesso.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Falha ao excluir o equipamento.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    if (_equipmentQuantityController.text.isEmpty ||
        _breakerLocationController.text.isEmpty ||
        _breakerStateController.text.isEmpty ||
        _wireTypeController.text.isEmpty ||
        _dimensionController.text.isEmpty ||
        (_selectCircuitType == null && _newEquipmentTypeName == null)) {
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
                const Text('Tipo:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_selectCircuitType ?? _newEquipmentTypeName ?? ''),
                const SizedBox(height: 10),
                const Text('Quantidade:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_equipmentQuantityController.text),
                const SizedBox(height: 10),
                const Text('Disjuntor(Local):',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_breakerLocationController.text),
                const SizedBox(height: 10),
                const Text('Disjuntor(Estado):',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_breakerStateController.text),
                const SizedBox(height: 10),
                const Text('Tipo de Fio:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_wireTypeController.text),
                const SizedBox(height: 10),
                const Text('Dimensão:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_dimensionController.text),
                const SizedBox(height: 10),
                const Text('Imagens:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  children: _images.map((imageData) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => _showImageDialog(imageData.imageFile,
                            existingImage: imageData),
                        child: Column(
                          children: [
                            Image.file(imageData.imageFile,
                                width: 100, height: 100, fit: BoxFit.cover),
                            Text(imageData.description),
                          ],
                        ),
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
              child: const Text('Adicionar'),
              onPressed: () {
                _registerEquipment();
              },
            ),
          ],
        );
      },
    );
  }

  void _registerEquipment() async {
    int? genericEquipmentCategory;
    int? personalEquipmentCategory;

    if (_isPersonalEquipmentCategorySelected) {
      genericEquipmentCategory = null;
      personalEquipmentCategory = _selectedPersonalEquipmentCategoryId;
    } else {
      genericEquipmentCategory = _selectedGenericEquipmentCategoryId;
      personalEquipmentCategory = null;
    }

    final EletricalCircuitRequestModel electricalCircuitModel =
        EletricalCircuitRequestModel(
      area: widget.areaId,
      system: widget.systemId,
    );

    final EletricalCircuitEquipmentRequestModel
        electricalCircuitEquipmentDetail =
        EletricalCircuitEquipmentRequestModel(
      genericEquipmentCategory: genericEquipmentCategory,
      personalEquipmentCategory: personalEquipmentCategory,
      eletricalCircuitRequestModel: electricalCircuitModel,
    );

    int? equipmentId = await equipmentService
        .createElectricalCircuit(electricalCircuitEquipmentDetail);

    if (equipmentId != null) {
      await Future.wait(_images.map((imageData) async {
        await equipmentPhotoService.createPhoto(
          EquipmentPhotoRequestModel(
            photo: imageData.imageFile,
            description: imageData.description,
            equipment: equipmentId,
          ),
        );
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Detalhes do equipamento registrados com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(
        context,
        '/electricalCircuitList',
        arguments: {
          'areaName': widget.areaName,
          'systemId': widget.systemId,
          'localName': widget.localName,
          'localId': widget.localId,
          'areaId': widget.areaId,
        },
      );
      setState(() {
        _equipmentQuantityController.clear();
        _breakerLocationController.clear();
        _breakerStateController.clear();
        _wireTypeController.clear();
        _dimensionController.clear();
        _selectCircuitType = null;
        _selectedPersonalEquipmentCategoryId = null;
        _selectedGenericEquipmentCategoryId = null;
        _images.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao registrar os detalhes do equipamento.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> combinedTypes = [
      ...genericEquipmentTypes,
      ...personalEquipmentTypes
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/electricalCircuitList',
              arguments: {
                'areaName': widget.areaName,
                'systemId': widget.systemId,
                'localName': widget.localName,
                'localId': widget.localId,
                'areaId': widget.areaId,
              },
            );
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
                child: Text('Adicionar Circuito Elétrico',
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
                  const Text('Tipos de Circuito Elétrico',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildStyledDropdown(
                          items: [
                                {
                                  'name':
                                      'Selecione o tipo de Circuito Elétrico',
                                  'id': -1,
                                  'type': -1
                                }
                              ] +
                              combinedTypes,
                          value: _selectCircuitType,
                          onChanged: (newValue) {
                            if (newValue !=
                                'Selecione o tipo de Circuito Elétrico') {
                              setState(() {
                                _selectCircuitType = newValue;
                                Map<String, Object> selected =
                                    combinedTypes.firstWhere((element) =>
                                        element['name'] == newValue);
                                _isPersonalEquipmentCategorySelected =
                                    selected['type'] == 'pessoal';
                                if (_isPersonalEquipmentCategorySelected) {
                                  _selectedPersonalEquipmentCategoryId =
                                      selected['id'] as int;
                                  _selectedGenericEquipmentCategoryId = null;
                                } else {
                                  _selectedGenericEquipmentCategoryId =
                                      selected['id'] as int;
                                  _selectedPersonalEquipmentCategoryId = null;
                                }
                              });
                            }
                          },
                          enabled: true,
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
                                if (personalEquipmentTypes.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Não existem equipamentos pessoais a serem excluídos.'),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _selectedTypeToDelete = null;
                                  });
                                  _showDeleteDialog();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectCircuitType = null;
                      });
                    },
                    child: const Text('Limpar seleção'),
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
                  const Text('Disjuntor(Local)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _breakerLocationController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Disjuntor(Estado)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _breakerStateController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Tipo de Fio',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _wireTypeController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Dimensão',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _dimensionController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
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
                          GestureDetector(
                            onTap: () => _showImageDialog(imageData.imageFile,
                                existingImage: imageData),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                imageData.imageFile,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
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
          title: const Text('Excluir tipo de Circuito Elétrico'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione um tipo de Circuito Elétrico para excluir:',
                textAlign: TextAlign.center,
              ),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedTypeToDelete,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTypeToDelete = newValue;
                      });
                    },
                    items: personalEquipmentTypes.map<DropdownMenuItem<String>>(
                        (Map<String, Object> value) {
                      return DropdownMenuItem<String>(
                        value: value['name'] as String,
                        child: Text(
                          value['name'] as String,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  );
                },
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
    required List<Map<String, Object>> items,
    String? value,
    required Function(String?) onChanged,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[300] : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        hint: Text(items.first['name'] as String,
            style: const TextStyle(color: Colors.grey)),
        value: value,
        isExpanded: true,
        underline: Container(),
        onChanged: enabled ? onChanged : null,
        items: items.map<DropdownMenuItem<String>>((Map<String, Object> value) {
          return DropdownMenuItem<String>(
            value: value['name'] as String,
            enabled: value['name'] != 'Selecione o tipo de Circuito Elétrico',
            child: Text(
              value['name'] as String,
              style: TextStyle(
                color: value['name'] == 'Selecione o tipo de Circuito Elétrico'
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
