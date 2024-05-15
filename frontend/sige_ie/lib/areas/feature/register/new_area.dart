import 'package:flutter/material.dart';
import 'package:sige_ie/areas/data/area_response_model.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/areas/data/area_request_model.dart';
import 'package:sige_ie/areas/data/area_service.dart';

class AreaLocation extends StatefulWidget {
  final String localName; // Nome do local, como uma sala ou área específica.
  final int localId;     // Identificador Númerico do local.
//Construtor que requer ambos,nome, ID do local, e uma chave opcional.
  const AreaLocation({Key? key, required this.localName, required this.localId})
      : super(key: key);
  @override
  _AreaLocationState createState() => _AreaLocationState();
}

class _AreaLocationState extends State<AreaLocation> {
  int? selectedFloor; // Andar selecionado pelo usuário.
  final TextEditingController areaController = TextEditingController();
//Controlador para entrada de Texto do nome da área.
  @override
  Widget build(BuildContext context) { // Constroi a Interface do Usuário com a Tela.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(  // Container para exibir o nome do local no topo.
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                // Nome da sala centralizado na página.
                child: Text('${widget.localName} - Sala',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            //Contéudo principal da tela para entrada de andar e nome da área.
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //Widget para entrada do numéro do andar.
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
                            //Alerta de Dialogo para Informar a opções de Andares que podem ser assinalados.
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
                  //widget para a entrada do nome da área
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
                  // Configuração de Campo de Preenchimento de Dados Solicitados.
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
                      controller: areaController,
                      decoration: InputDecoration(
                        hintText: 'Digite o nome da Sala',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  // Botões de Controle para voltar ou continuar com o cadastro da área.
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Configuração de Formato e Cor de Botão Personalizados.
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
                        //Botão para voltar a tela anterior, não processeguindo o cadastro de área.
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/homeScreen',
                          );
                        },
                        child: Text('ENCERRAR'),
                      ),
                      // Configuração de Formato e Cor do Botão personalizada.
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
                        //Botão para continuar com cadastro de área e cadastra area com a verificação necessária dos dados solicitados.
                        onPressed: () async {
                          if (selectedFloor != null &&
                              areaController.text.isNotEmpty) {
                            AreaService areaService = AreaService();
                            try {
                              AreaResponseModel newArea =
                                  await areaService.createArea(AreaRequestModel(
                                name: areaController.text,
                                floor: selectedFloor,
                                place: widget.localId,
                              ));
                              print(
                                  'Sala Registrada: ${newArea.name} no ${newArea.floor}° andar');
                              Navigator.pushNamed(context, '/systemLocation',
                                  arguments: {
                                    'areaName': newArea.name,
                                    'localName': widget.localName,
                                    'localId': widget.localId,
                                    'areaId': newArea.id,
                                  });
                            } catch (e) {
                              showDialog(
                                // Caixa de Dialogo, apresentando Falha ao criar Sala, pois a verificação não foi validada.
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erro'),
                                    content: Text("Falha ao criar sala: $e"),
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
                              //Mostra uma caixa de dialogo solicitando o preenchimento do campos acima, se tal ação não foi realizada.
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
//Mostra um Menu com uma lista das opções disponivéis.
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
