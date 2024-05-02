import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';

class RoomLocation extends StatefulWidget {
  @override
  _RoomLocationState createState() => _RoomLocationState();
}

class _RoomLocationState extends State<RoomLocation> {
  String? selectedFloor;
  final TextEditingController roomController = TextEditingController();
  final List<String> floors = ['Andar 1', 'Andar 2', 'Andar 3', 'Andar 4', 'Andar 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('Local-Sala',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Andar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: selectedFloor,
                          hint: Text('Selecione o Andar'),
                          isExpanded: true,
                          items: floors.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedFloor = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Sala', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
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
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.sigeIeYellow),
                          foregroundColor: MaterialStateProperty.all(AppColors.sigeIeBlue),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: () {
                          if (selectedFloor != null && roomController.text.isNotEmpty) {
                            // Se desejar, insira a lógica de navegação para outra tela aqui
                            print('Sala Registrada: ${roomController.text} no ${selectedFloor}');
                            // Por exemplo, mudar para uma nova rota:
                            Navigator.of(context).pushNamed('/systemLocation');
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text("Por favor, selecione um andar e digite o nome da sala"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('ENCERRAR'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



























































































