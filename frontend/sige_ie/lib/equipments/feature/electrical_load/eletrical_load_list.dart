import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/feature/electrical_load/add_electrical_load.dart';

class ListElectricalLoadEquipment extends StatefulWidget {
  final String areaName;
  final String localName;
  final int categoryNumber;
  final int localId;
  final int areaId;

  const ListElectricalLoadEquipment({
    Key? key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
    required this.areaId,
  }) : super(key: key);

  @override
  _ListElectricalLoadEquipmentState createState() =>
      _ListElectricalLoadEquipmentState();
}

class _ListElectricalLoadEquipmentState
    extends State<ListElectricalLoadEquipment> {
  List<String> equipmentList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEquipmentList();
  }

  Future<void> fetchEquipmentList() async {
    // Simulação de requisição ou carga de dados
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // Exemplo de lista de equipamentos (vazia neste caso)
      equipmentList = [];
      isLoading = false;
    });
  }

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElectricalLoadEquipmentScreen(
          areaName: widget.areaName,
          categoryNumber: widget.categoryNumber,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String systemTitle = 'CARGAS ELÉTRICAS';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/systemLocation',
              arguments: {
                'areaName': widget.areaName,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child: Text('${widget.areaName} - $systemTitle',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightText)),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : equipmentList.isNotEmpty
                          ? Column(
                              children: equipmentList.map((equipment) {
                                return ListTile(
                                  title: Text(equipment),
                                );
                              }).toList(),
                            )
                          : const Center(
                              child: Text(
                                'Você ainda não tem equipamentos',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddEquipment(context),
        backgroundColor: AppColors.sigeIeYellow,
        child: const Icon(Icons.add, color: AppColors.sigeIeBlue),
      ),
    );
  }
}
