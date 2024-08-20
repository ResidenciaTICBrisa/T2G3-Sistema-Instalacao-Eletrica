import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_response_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_service.dart';

import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_request_model.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_response_model.dart';
import 'package:sige_ie/shared/data/equipment-photo/equipment_photo_service.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_response_model.dart';
import 'package:sige_ie/shared/data/generic-equipment-category/generic_equipment_category_service.dart';
import 'package:sige_ie/equipments/data/equipment_service.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_equipment_request_model.dart';
import 'package:sige_ie/equipments/data/eletrical_circuit/eletrical_circuit_request_model.dart';
import 'package:sige_ie/shared/data/personal-equipment-category/personal_equipment_category_request_model.dart';
import 'package:sige_ie/shared/data/personal-equipment-category/personal_equipment_category_service.dart';

class ImageData {
  int id;
  File imageFile;
  String description;
  bool toDelete;

  ImageData({
    int? id,
    required this.imageFile,
    required this.description,
    this.toDelete = false,
  }) : id = id ?? -1;
}

List<ImageData> _images = [];

class AddElectricalCircuit extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int systemId;
  final int areaId;
  final int? electricalCircuitId;
  final bool isEdit;

  const AddElectricalCircuit({
    super.key,
    required this.areaName,
    required this.systemId,
    required this.localName,
    required this.localId,
    required this.areaId,
    this.electricalCircuitId,
    this.isEdit = false,
  });

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddElectricalCircuit> {
  EquipmentService equipmentService = EquipmentService();
  EletricalCircuitEquipmentService electricalCircuitService =
      EletricalCircuitEquipmentService();
  EquipmentPhotoService equipmentPhotoService = EquipmentPhotoService();
  PersonalEquipmentCategoryService personalEquipmentCategoryService =
      PersonalEquipmentCategoryService();
  GenericEquipmentCategoryService genericEquipmentCategoryService =
      GenericEquipmentCategoryService();
  final TextEditingController _observationsController = TextEditingController();
  final TextEditingController _conductorSpecificationController =
      TextEditingController();
  final TextEditingController _gaugeController = TextEditingController();
  String? _selectedType;
  String? _selectedCircuitBreaker;
  int? _selectedGenericEquipmentCategoryId;
  int? _selectedPersonalEquipmentCategoryId;
  bool _isPersonalEquipmentCategorySelected = false;
  String? _newEquipmentTypeName;
  String? _selectedTypeToDelete;
  int? equipmentId;
  List<Map<String, Object>> genericEquipmentTypes = [];
  List<Map<String, Object>> personalEquipmentTypes = [];
  Map<String, int> personalEquipmentMap = {};
  EletricalCircuitResponseModel? electricalCircuitResponseModel;

  @override
  void initState() {
    super.initState();
    _fetchEquipmentCategory();
    if (widget.isEdit && widget.electricalCircuitId != null) {
      _initializeData(widget.electricalCircuitId!);
    }
  }

  Future<void> _initializeData(int electricalCircuitId) async {
    try {
      await _fetchElectricalCircuit(electricalCircuitId);

      if (electricalCircuitResponseModel != null) {
        setState(() {
          equipmentId = electricalCircuitResponseModel!.equipment;
          _observationsController.text =
              electricalCircuitResponseModel!.observation ?? '';
          _conductorSpecificationController.text =
              electricalCircuitResponseModel!.type_wire;
          _gaugeController.text =
              electricalCircuitResponseModel!.size.toString();
          _selectedCircuitBreaker =
              electricalCircuitResponseModel!.type_circuit_breaker;

          _fetchEquipmentDetails(electricalCircuitResponseModel!.equipment);
          _fetchExistingPhotos(electricalCircuitResponseModel!.equipment);
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _fetchElectricalCircuit(int electricalCircuitId) async {
    electricalCircuitResponseModel = await electricalCircuitService
        .getEletricalCircuitById(electricalCircuitId);
  }

  Future<void> _fetchEquipmentDetails(int equipmentId) async {
    try {
      final equipmentDetails =
          await equipmentService.getEquipmentById(equipmentId);

      setState(() {
        _isPersonalEquipmentCategorySelected =
            equipmentDetails['personal_equipment_category'] != null;

        if (_isPersonalEquipmentCategorySelected) {
          _selectedPersonalEquipmentCategoryId =
              equipmentDetails['personal_equipment_category'];
          _selectedType = personalEquipmentTypes.firstWhere((element) =>
                  element['id'] == _selectedPersonalEquipmentCategoryId)['name']
              as String;
        } else {
          _selectedGenericEquipmentCategoryId =
              equipmentDetails['generic_equipment_category'];
          _selectedType = genericEquipmentTypes.firstWhere((element) =>
                  element['id'] == _selectedGenericEquipmentCategoryId)['name']
              as String;
        }
      });
    } catch (e) {
      print('Erro ao buscar detalhes do equipamento: $e');
    }
  }

  void _fetchExistingPhotos(int equipmentId) async {
    try {
      List<EquipmentPhotoResponseModel> photos =
          await equipmentPhotoService.getPhotosByEquipmentId(equipmentId);

      List<ImageData> imageList = [];

      for (var photo in photos) {
        File imageFile = await photo.toFile();
        imageList.add(ImageData(
          id: photo.id,
          imageFile: imageFile,
          description: photo.description ?? '',
        ));
      }

      setState(() {
        _images = imageList;
      });
    } catch (e) {
      print('Erro ao buscar fotos existentes: $e');
    }
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
    _images.clear();
    _observationsController.dispose();
    _conductorSpecificationController.dispose();
    _gaugeController.dispose();
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
    TextEditingController descriptionController = TextEditingController(
      text: existingImage?.description ?? '',
    );
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
                  String? description = descriptionController.text.isEmpty
                      ? null
                      : descriptionController.text;
                  if (existingImage != null) {
                    existingImage.description = description ?? '';
                  } else {
                    final imageData = ImageData(
                      imageFile: imageFile,
                      description: description ?? '',
                    );
                    _images.add(imageData);
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
                    _newEquipmentTypeName = typeController.text;
                  });
                  _registerPersonalEquipmentType().then((_) {
                    setState(() {
                      _selectedType = null;
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

  void _updateEquipment() async {
    int? genericEquipmentCategory;
    int? personalEquipmentCategory;

    if (_isPersonalEquipmentCategorySelected) {
      genericEquipmentCategory = null;
      personalEquipmentCategory = _selectedPersonalEquipmentCategoryId;
    } else {
      genericEquipmentCategory = _selectedGenericEquipmentCategoryId;
      personalEquipmentCategory = null;
    }

    final Map<String, dynamic> equipmentTypeUpdate = {
      "generic_equipment_category": genericEquipmentCategory,
      "personal_equipment_category": personalEquipmentCategory,
    };

    print('Equipment Type Update: $equipmentTypeUpdate');

    bool typeUpdateSuccess = await equipmentService.updateEquipment(
        equipmentId!, equipmentTypeUpdate);

    if (typeUpdateSuccess) {
      final EletricalCircuitRequestModel electricalCircuitModel =
          EletricalCircuitRequestModel(
        area: widget.areaId,
        system: widget.systemId,
        observation: _observationsController.text.isNotEmpty
            ? _observationsController.text
            : null,
        size: int.tryParse(_gaugeController.text),
        type_wire: _conductorSpecificationController.text,
        type_circuit_breaker: _selectedCircuitBreaker ?? '',
      );

      print('Electrical Circuit Model: ${electricalCircuitModel.toJson()}');

      bool electricalCircuitUpdateSuccess =
          await electricalCircuitService.updateEletricalCircuit(
              widget.electricalCircuitId!, electricalCircuitModel);

      if (electricalCircuitUpdateSuccess) {
        await Future.wait(_images
            .where((imageData) => imageData.toDelete)
            .map((imageData) async {
          await equipmentPhotoService.deletePhoto(imageData.id);
        }));

        await Future.wait(_images
            .where((imageData) => !imageData.toDelete)
            .map((imageData) async {
          if (imageData.id == -1) {
            await equipmentPhotoService.createPhoto(
              EquipmentPhotoRequestModel(
                photo: imageData.imageFile,
                description: imageData.description.isEmpty
                    ? null
                    : imageData.description,
                equipment: equipmentId!,
              ),
            );
          } else {
            await equipmentPhotoService.updatePhoto(
              imageData.id,
              EquipmentPhotoRequestModel(
                photo: imageData.imageFile,
                description: imageData.description.isEmpty
                    ? null
                    : imageData.description,
                equipment: equipmentId!,
              ),
            );
          }
        }));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Detalhes do equipamento atualizados com sucesso.'),
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
          _selectedType = null;
          _selectedPersonalEquipmentCategoryId = null;
          _selectedGenericEquipmentCategoryId = null;
          _images.clear();
          _observationsController.clear();
          _conductorSpecificationController.clear();
          _gaugeController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha ao atualizar os detalhes do equipamento.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao atualizar o tipo do equipamento.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          content:
              Text('Equipamento de circuito elétrico registrado com sucesso.'),
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
          content:
              Text('Falha ao registrar o equipamento de circuito elétrico.'),
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

    int personalCategoryId = personalEquipmentMap[_selectedTypeToDelete]!;

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
                    .deletePersonalEquipmentCategory(personalCategoryId);

                if (success) {
                  setState(() {
                    personalEquipmentTypes.removeWhere(
                        (element) => element['name'] == _selectedTypeToDelete);
                    _selectedTypeToDelete = null;
                    _selectedType = null;
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
    if (_selectedType == null &&
        _newEquipmentTypeName == null &&
        _selectedCircuitBreaker == null &&
        _conductorSpecificationController.text.isEmpty &&
        _gaugeController.text.isEmpty) {
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
                Text(_selectedType ?? _newEquipmentTypeName ?? ''),
                const SizedBox(height: 10),
                const Text('Disjuntor (tipo):',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_selectedCircuitBreaker ?? ''),
                const SizedBox(height: 10),
                const Text('Especificação do Condutor:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_conductorSpecificationController.text),
                const SizedBox(height: 10),
                const Text('Bitola:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_gaugeController.text),
                const SizedBox(height: 10),
                const Text('Observações:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_observationsController.text),
                const SizedBox(height: 10),
                const Text('Imagens:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  children: _images
                      .where((imageData) => !imageData.toDelete)
                      .map((imageData) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => _showImageDialog(imageData.imageFile,
                            existingImage: imageData),
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
              child: widget.isEdit
                  ? const Text('Atualizar')
                  : const Text('Adicionar'),
              onPressed: () {
                if (widget.isEdit) {
                  _updateEquipment();
                } else {
                  _registerEquipment();
                }
                Navigator.of(context).pop();
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
      observation: _observationsController.text.isNotEmpty
          ? _observationsController.text
          : null,
      size: int.tryParse(_gaugeController.text),
      type_wire: _conductorSpecificationController.text,
      type_circuit_breaker: _selectedCircuitBreaker ?? '',
    );

    final EletricalCircuitEquipmentRequestModel
        electricalCircuitEquipmentDetail =
        EletricalCircuitEquipmentRequestModel(
      genericEquipmentCategory: genericEquipmentCategory,
      personalEquipmentCategory: personalEquipmentCategory,
      eletricalCircuitRequestModel: electricalCircuitModel,
    );

    int? id = await equipmentService
        .createElectricalCircuit(electricalCircuitEquipmentDetail);
    setState(() {
      equipmentId = id;
    });

    if (equipmentId != null && equipmentId != 0) {
      await Future.wait(_images.map((imageData) async {
        await equipmentPhotoService.createPhoto(
          EquipmentPhotoRequestModel(
            photo: imageData.imageFile,
            description:
                imageData.description.isEmpty ? null : imageData.description,
            equipment: equipmentId!,
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
        _selectedType = null;
        _selectedPersonalEquipmentCategoryId = null;
        _selectedGenericEquipmentCategoryId = null;
        _images.clear();
        _observationsController.clear();
        _conductorSpecificationController.clear();
        _gaugeController.clear();
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

  Future<void> _deletePhoto(int photoId) async {
    setState(() {
      _images.firstWhere((imageData) => imageData.id == photoId).toDelete =
          true;
    });
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
            setState(() {
              _selectedType = null;
              _selectedPersonalEquipmentCategoryId = null;
              _selectedGenericEquipmentCategoryId = null;
              _images.clear();
              _observationsController.clear();
              _conductorSpecificationController.clear();
              _gaugeController.clear();
            });
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
              child: Center(
                child: Text(
                  widget.electricalCircuitId == null
                      ? 'Adicionar Equipamento'
                      : 'Editar Equipamento',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
                          value: _selectedType,
                          onChanged: (newValue) {
                            if (newValue !=
                                'Selecione o tipo de Circuito Elétrico') {
                              setState(() {
                                _selectedType = newValue;
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
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedType = null;
                      });
                    },
                    child: const Text('Limpar seleção'),
                  ),
                  const Text('Disjuntor (tipo)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    hint: const Text(
                      'Escolha um tipo',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _selectedCircuitBreaker,
                    isExpanded: true,
                    underline: Container(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCircuitBreaker = newValue;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Magnético',
                        child: Text('Magnético'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'DR',
                        child: Text('DR'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Especificação do Condutor',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _conductorSpecificationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Digite a especificação do condutor',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Bitola',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _gaugeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Digite a bitola',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Observações',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _observationsController,
                      maxLines: 3,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText:
                            'Digite suas observações aqui (máx 500 caracteres)',
                      ),
                      buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) {
                        return Text(
                          '$currentLength / $maxLength',
                          style: TextStyle(
                            fontSize: 12,
                            color: currentLength > maxLength!
                                ? Colors.red
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _pickImage,
                  ),
                  Wrap(
                    children: _images
                        .where((imageData) => !imageData.toDelete)
                        .map((imageData) {
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
                              _deletePhoto(imageData.id);
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
                      child: Text(
                        widget.isEdit
                            ? 'ATUALIZAR EQUIPAMENTO'
                            : 'ADICIONAR EQUIPAMENTO',
                        style: const TextStyle(
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
        hint: Text(
            items.isNotEmpty
                ? items.first['name'] as String
                : 'Selecione uma opção',
            style: const TextStyle(color: Colors.grey)),
        value: items.any((item) => item['name'] == value) ? value : null,
        isExpanded: true,
        underline: Container(),
        onChanged: enabled ? onChanged : null,
        items: items.map<DropdownMenuItem<String>>((Map<String, Object> item) {
          return DropdownMenuItem<String>(
            value: item['name'] as String,
            enabled: item['name'] != 'Escolha um tipo',
            child: Text(
              item['name'] as String,
              style: TextStyle(
                color: item['name'] == 'Escolha um tipo'
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
