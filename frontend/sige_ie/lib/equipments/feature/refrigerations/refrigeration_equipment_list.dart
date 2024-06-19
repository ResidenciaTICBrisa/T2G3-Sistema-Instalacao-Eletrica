import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/equipments/data/refrigerations/refrigerations_service.dart';
import 'package:sige_ie/equipments/feature/refrigerations/add_refrigeration.dart';

class ListRefrigerationEquipment extends StatefulWidget {
  final String areaName;
  final String localName;
  final int categoryNumber;
  final int localId;
  final int areaId;

  const ListRefrigerationEquipment({
    Key? key,
    required this.areaName,
    required this.categoryNumber,
    required this.localName,
    required this.localId,
    required this.areaId,
  }) : super(key: key);

  @override
  _ListRefrigerationEquipmentState createState() =>
      _ListRefrigerationEquipmentState();
}

class _ListRefrigerationEquipmentState
    extends State<ListRefrigerationEquipment> {
  List<String> equipmentList = [];
  bool isLoading = true;
  final RefrigerationsEquipmentService _service =
      RefrigerationsEquipmentService();

  @override
  void initState() {
    super.initState();
    fetchEquipmentList();
  }

  Future<void> fetchEquipmentList() async {
    try {
      final List<String> equipmentList =
          await _service.getRefrigerationsListByArea(widget.areaId);
      if (mounted) {
        setState(() {
          this.equipmentList = equipmentList;
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
        builder: (context) => AddRefrigeration(
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
    String systemTitle = 'Refrigeração';

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
