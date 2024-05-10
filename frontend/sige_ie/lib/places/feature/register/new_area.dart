import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/places/models/area_request_model.dart';
import 'package:sige_ie/places/services/area_service.dart';

class RoomLocation extends StatefulWidget {
  final String localName;
  final int localId;

  const RoomLocation({Key? key, required this.localName, required this.localId})
      : super(key: key);
  @override
  _RoomLocationState createState() => _RoomLocationState();
}

class _RoomLocationState extends State<RoomLocation> {
  int? selectedFloor;
  final TextEditingController roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('${widget.localName} - Sala',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text('Andar',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Informação sobre os Andares'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('0 = Térreo',
                                        style: TextStyle(fontSize: 16)),
                                    Text('1 = 1° Andar',
                                        style: TextStyle(fontSize: 16)),
                                    Text('2 = 2° Andar',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: TextEditingController(
                          text: selectedFloor?.toString()),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedFloor = int.tryParse(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Sala',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: roomController,
                      decoration: InputDecoration(
                        hintText: 'Digite o nome da Sala',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.sigeIeBlue,
                          backgroundColor: AppColors.sigeIeYellow,
                          minimumSize: Size(150, 50),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          if (selectedFloor != null &&
                              roomController.text.isNotEmpty) {
                            AreaService areaService = AreaService();
                            bool result =
                                await areaService.createRoom(RoomRequestModel(
                              name: roomController.text,
                              floor: selectedFloor,
                              place: widget.localId,
                            ));
                            if (result) {
                              print(
                                  'Sala Registrada: ${roomController.text} no $selectedFloor° andar');
                              Navigator.pushNamed(context, '/systemLocation',
                                  arguments: {
                                    'roomName': roomController.text,
                                    'localName': widget.localName,
                                    'localId': widget.localId
                                  });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erro'),
                                    content: Text("Falha ao criar sala."),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text(
                                      "Por favor, selecione um andar e digite o nome da sala"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('CONTINUAR'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.lightText,
                          backgroundColor: AppColors.warn,
                          minimumSize: Size(150, 50),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/homeScreen',
                          );
                        },
                        child: Text('ENCERRAR'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDropdown({
  required List<String> items,
  required String? value,
  required void Function(String?) onChanged,
  VoidCallback? addNew,
}) {
  return Container(
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
  );
}
