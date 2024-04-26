import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'position.dart';

class newLocation extends StatefulWidget {
  @override
  _newLocationState createState() => _newLocationState();
}

class _newLocationState extends State<newLocation> {
  String coordinates = '';
  bool Coord = false;
  final TextEditingController _nameController = TextEditingController();
  late PositionController positionController;

  @override
  void initState() {
    super.initState();
    positionController = PositionController();
  }

  void _getCoordinates() {
    positionController.getPosition().then((_) {
      setState(() {
        if (positionController.error.isEmpty) {
          coordinates =
              "Latitude: ${positionController.lat}, Longitude: ${positionController.long}";
          Coord = true;
        } else {
          coordinates = "Erro: ${positionController.error}";
          Coord = false;
        }
      });
    }).catchError((e) {
      setState(() {
        coordinates = "Erro ao obter localização: $e";
        Coord = false;
      });
    });
  }

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
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('Registrar Novo Local',
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
                  Text('Coordenadas',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Cinza claro
                      borderRadius:
                          BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  'Clique na lupa para obter as coordenadas',
                              border: InputBorder.none, // Sem bordas internas
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10), // Padding interno
                            ),
                            controller:
                                TextEditingController(text: coordinates),
                            enabled: false,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: _getCoordinates,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Nome do Local',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Cinza claro
                      borderRadius:
                          BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Digite o nome do local',
                        border: InputBorder.none, // Sem bordas internas
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10), // Padding interno
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Center(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeYellow),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.sigeIeBlue),
                      minimumSize: MaterialStateProperty.all(
                          Size(200, 50)), // Tamanho maior para o botão
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 18, // Aumentar o tamanho do texto
                          fontWeight:
                              FontWeight.bold, // Deixar o texto em negrito
                        ),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Bordas arredondadas com raio de 25
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (Coord && _nameController.text.trim().isNotEmpty) {
                        // Código para registrar o local
                        print('Local Registrado: ${_nameController.text}');
                        Navigator.of(context).pushNamed('?');
                      } else if (_nameController.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Erro"),
                              content: Text(
                                  "Por favor, insira um nome para o local"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Fecha o dialogo
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Registrar'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
