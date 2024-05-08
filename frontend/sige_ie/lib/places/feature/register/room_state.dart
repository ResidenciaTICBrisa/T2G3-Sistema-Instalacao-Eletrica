import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class RoomLocation extends StatefulWidget {
  final String localName;
  const RoomLocation({Key? key, required this.localName}) : super(key: key);

  @override
  _RoomLocationState createState() => _RoomLocationState();
}

class _RoomLocationState extends State<RoomLocation> {
  String? selectedFloor;
  final TextEditingController roomController = TextEditingController();
  final List<String> floors = [
    'Térreo',
    '1° Andar',
    '2° Andar',
    '3° Andar',
    '4° Andar'
  ];

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
                  Text('Andar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 10),
                  _buildDropdown(
                      items: floors,
                      value: selectedFloor,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFloor = newValue;
                        });
                      }),
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
                          minimumSize: Size(165, 50),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (selectedFloor != null &&
                              roomController.text.isNotEmpty) {
                            print(
                                'Sala Registrada: ${roomController.text} no ${selectedFloor}');
                            Navigator.pushNamed(context, '/systemLocation',
                                arguments: roomController.text);
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
                          minimumSize: Size(165, 50),
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
                            '/', //Rota temporária, modificar depois
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
}
