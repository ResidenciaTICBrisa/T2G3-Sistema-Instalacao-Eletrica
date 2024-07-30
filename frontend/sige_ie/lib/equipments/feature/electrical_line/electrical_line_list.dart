import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/eletrical_line/eletrical_line_response_by_area_model.dart';
import 'package:sige_ie/equipments/data/eletrical_line/eletrical_line_service.dart';
import 'package:sige_ie/equipments/feature/electrical_line/add_electrical_line.dart';

class ListElectricalLineEquipment extends StatefulWidget {
  final String areaName;
  final String localName;
  final int systemId;
  final int localId;
  final int areaId;

  const ListElectricalLineEquipment({
    Key? key,
    required this.areaName,
    required this.systemId,
    required this.localName,
    required this.localId,
    required this.areaId,
  }) : super(key: key);

  @override
  _ListElectricalLineEquipmentState createState() =>
      _ListElectricalLineEquipmentState();
}

class _ListElectricalLineEquipmentState
    extends State<ListElectricalLineEquipment> {
  List<String> equipmentList = [];
  bool isLoading = true;
  final EletricalLineEquipmentService _service =
      EletricalLineEquipmentService();

  @override
  void initState() {
    super.initState();
    fetchEquipmentList();
  }

  Future<void> fetchEquipmentList() async {
    try {
      final List<EletricalLineEquipmentResponseByAreaModel> equipmentList =
          await _service.getEletricalLineListByArea(widget.areaId);
      if (mounted) {
        setState(() {
/*           this.equipmentList = equipmentList;
 */
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching equipment list: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void navigateToAddEquipment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddElectricalLineScreen(
          areaName: widget.areaName,
          systemId: widget.systemId,
          localName: widget.localName,
          localId: widget.localId,
          areaId: widget.areaId,
        ),
      ),
    );
  }

  void _editEquipment(BuildContext context, String equipment) {
    // Implement the logic to edit the equipment
  }

  void _deleteEquipment(BuildContext context, String equipment) {
    // Implement the logic to delete the equipment
  }

  @override
  Widget build(BuildContext context) {
    String systemTitle = 'Linhas Elétricas';

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
                child: Text(
                  '${widget.areaName} - $systemTitle',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightText,
                  ),
                ),
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
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.sigeIeBlue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              equipment,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () => _editEquipment(
                                              context, equipment),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () => _deleteEquipment(
                                              context, equipment),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Center(
                              child: Text(
                                'Você ainda não tem equipamentos',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
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
