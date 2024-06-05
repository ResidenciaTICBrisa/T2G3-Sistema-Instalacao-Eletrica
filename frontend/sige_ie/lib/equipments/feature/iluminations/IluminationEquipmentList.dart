import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/feature/iluminations/addIluminationEquipment.dart';

class listIluminationEquipment extends StatelessWidget {
  final String areaName;
  final String localName;
  final int categoryNumber;
  final int localId;
  final int areaId;

  const listIluminationEquipment({
    super.key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
    required this.areaId,
  });

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddiluminationEquipmentScreen(
          areaName: areaName,
          categoryNumber: categoryNumber,
          localName: localName,
          localId: localId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> equipmentList = [
      // Vazio para simular nenhum equipamento
    ];

    String systemTitle = 'ILUMINAÇÃO';

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
                'areaName': areaName,
                'localName': localName,
                'localId': localId,
                'areaId': areaId,
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
                child: Text('$areaName - $systemTitle',
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
                  equipmentList.isNotEmpty
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
