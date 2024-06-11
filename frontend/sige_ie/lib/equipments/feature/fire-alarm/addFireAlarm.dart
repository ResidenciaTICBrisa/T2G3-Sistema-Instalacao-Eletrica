import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_response_model.dart';
import 'package:sige_ie/equipments/data/equipment-type/equipment_type_service.dart';
import 'package:sige_ie/equipments/data/equipment_detail_service.dart';
import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_equipment_detail_request_model.dart';
import 'package:sige_ie/equipments/data/fire-alarm/fire_alarm_request_model.dart';
import 'package:sige_ie/equipments/data/mix-equipment-type/mix-equipment-type-service.dart';
import 'package:sige_ie/equipments/data/personal-equipment-type/personal_equipment_type_request_model.dart';
import 'package:sige_ie/equipments/data/personal-equipment-type/personal_equipment_type_service.dart';
import 'package:sige_ie/equipments/data/photo/photo_request_model.dart';

class ImageData {
  File imageFile;
  int id;
  String description;

  ImageData(this.imageFile, this.description) : id = Random().nextInt(1000000);
}

List<ImageData> _images = [];
Map<int, List<ImageData>> categoryImagesMap = {};

class AddfireAlarm extends StatefulWidget {
  final String areaName;
  final String localName;
  final int localId;
  final int categoryNumber;
  final int areaId;

  const AddfireAlarm({
    super.key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
    required this.areaId,
  });

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddfireAlarm> {
  EquipmentDetailService equipmentDetailService = EquipmentDetailService();
  PersonalEquipmentTypeService personalEquipmentTypeService =
      PersonalEquipmentTypeService();
  EquipmentTypeService equipmentTypeService = EquipmentTypeService();
  MixEquipmentTypeService mixEquipmentTypeService = MixEquipmentTypeService();
  final _equipmentQuantityController = TextEditingController();
  String? _selectedType;
  String? _selectedTypeToDelete;
  String? _newEquipmentTypeName;
  int? _selectedTypeId;
  int? _selectedPersonalEquipmentTypeId;

  List<String> equipmentTypes = [];
  List<String> personalEquipmentTypes = [];
  Map<String, int> personalEquipmentMap = {};

  @override
  void initState() {
    super.initState();
    _fetchEquipmentTypes();
  }

  Future<void> _fetchEquipmentTypes() async {
    List<EquipmentTypeResponseModel> equipmentTypeList =
        await equipmentTypeService
            .getAllEquipmentTypeBySystem(widget.categoryNumber);

    List<EquipmentTypeResponseModel> personalEquipmentList =
        await personalEquipmentTypeService
            .getAllPersonalEquipmentBySystem(widget.categoryNumber);

    List<EquipmentTypeResponseModel> equipmentList =
        await mixEquipmentTypeService.getAllEquipmentBySystem(
            widget.categoryNumber, equipmentTypeList, personalEquipmentList);

    setState(() {
      equipmentTypes = equipmentList.map((e) => e.name).toList();
      personalEquipmentTypes =
          personalEquipmentList.map((e) => e.name).toList();
      personalEquipmentMap = {
        for (var equipment in personalEquipmentList)
          equipment.name: equipment.id
      };
    });
  }

  @override
  void dispose() {
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
                  if (existingImage != null) {
                    existingImage.description = descriptionController.text;
                  } else {
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
                      _selectedTypeId = null;
                      _fetchEquipmentTypes();
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
    int systemId = widget.categoryNumber;
    PersonalEquipmentTypeRequestModel personalEquipmentTypeRequestModel =
        PersonalEquipmentTypeRequestModel(
            name: _newEquipmentTypeName ?? '', system: systemId);

    int id = await personalEquipmentTypeService
        .createPersonalEquipmentType(personalEquipmentTypeRequestModel);

    if (id != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Equipamento de alarme de incêndio registrado com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        personalEquipmentTypes.add(_newEquipmentTypeName!);
        personalEquipmentMap[_newEquipmentTypeName!] = id;
        _newEquipmentTypeName = null;
        _fetchEquipmentTypes();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Falha ao registrar o equipamento de alarme de incêndio.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteEquipmentType() async {
    if (personalEquipmentTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não existem equipamentos pessoais a serem excluídos.'),
        ),
      );
      return;
    }

    if (_selectedTypeToDelete == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Selecione um tipo de equipamento válido para excluir.'),
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
                bool success = await personalEquipmentTypeService
                    .deletePersonalEquipmentType(equipmentId);

                if (success) {
                  setState(() {
                    personalEquipmentTypes.remove(_selectedTypeToDelete);
                    _selectedTypeToDelete = null;
                    _fetchEquipmentTypes();
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
        (_selectedType == null && _newEquipmentTypeName == null)) {
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
                const Text('Quantidade:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_equipmentQuantityController.text),
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
              child: const Text('Adicionar'),
              onPressed: () {
                _registerEquipmentDetail();
              },
            ),
          ],
        );
      },
    );
  }

  void _registerEquipmentDetail() async {
    List<PhotoRequestModel> photos = _images.map((imageData) {
      return PhotoRequestModel(
          photo: base64Encode(imageData.imageFile.readAsBytesSync()),
          description:
              imageData.description.isNotEmpty ? imageData.description : '');
    }).toList();

    final FireAlarmRequestModel fireAlarmModel = FireAlarmRequestModel(
        area: widget.areaId, system: widget.categoryNumber);

    final FireAlarmEquipmentDetailRequestModel fireAlarmEquipmentDetail =
        FireAlarmEquipmentDetailRequestModel(
      equipmentType: _selectedTypeId,
      personalEquipmentType: _selectedPersonalEquipmentTypeId,
      fireAlarm: fireAlarmModel,
      photos: photos,
    );

    bool success =
        await equipmentDetailService.createFireAlarm(fireAlarmEquipmentDetail);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Detalhes do equipamento registrados com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(
        context,
        '/listFireAlarms',
        arguments: {
          'areaName': widget.areaName,
          'categoryNumber': widget.categoryNumber,
          'localName': widget.localName,
          'localId': widget.localId,
          'areaId': widget.areaId,
        },
      );
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
    Set<String> combinedTypesSet = {
      ...equipmentTypes,
      ...personalEquipmentTypes
    };
    List<String> combinedTypes = combinedTypesSet.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/listFireAlarms',
              arguments: {
                'areaName': widget.areaName,
                'categoryNumber': widget.categoryNumber,
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
                  const Text('Tipos de alarme de incêndio',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildStyledDropdown(
                          items: ['Selecione o tipo de alarme de incêndio'] +
                              combinedTypes,
                          value: _selectedType,
                          onChanged: (newValue) {
                            if (newValue !=
                                'Selecione o tipo de alarme de incêndio') {
                              setState(() {
                                _selectedType = newValue;
                                _selectedPersonalEquipmentTypeId =
                                    personalEquipmentMap[newValue] ?? -1;
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
                        _selectedType = null;
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
                    items: personalEquipmentTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
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
    required List<String> items,
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
        hint: Text(items.first, style: const TextStyle(color: Colors.grey)),
        value: value,
        isExpanded: true,
        underline: Container(),
        onChanged: enabled ? onChanged : null,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value.isEmpty ? null : value,
            enabled: value != 'Selecione o tipo de alarme de incêndio',
            child: Text(
              value,
              style: TextStyle(
                color: value == 'Selecione o tipo de alarme de incêndio'
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
