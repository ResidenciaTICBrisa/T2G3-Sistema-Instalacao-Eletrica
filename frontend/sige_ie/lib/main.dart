import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/core/ui/splash_screen.dart';
import 'package:sige_ie/equipments/feature/atmospheric-discharges/atmospheric-dischargesList.dart';
import 'package:sige_ie/equipments/feature/cooling/coolingEquipmentList.dart';
import 'package:sige_ie/equipments/feature/distribuition-Board/distribuitionBoardEquipmentList.dart';
import 'package:sige_ie/equipments/feature/electrical-line/electricaLLineLIst.dart';
import 'package:sige_ie/equipments/feature/electrical-load/eletricalLoadList.dart';
import 'package:sige_ie/equipments/feature/fire-alarm/fireAlarmList.dart';
import 'package:sige_ie/equipments/feature/structured-cabling/struturedCablingEquipmentList.dart';
import 'package:sige_ie/facilities/ui/facilities.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/maps/feature/maps.dart';
import 'package:sige_ie/equipments/feature/iluminations/IluminationEquipmentList.dart';
import 'package:sige_ie/equipments/feature/systemConfiguration.dart';
import 'package:sige_ie/places/feature/register/new_place.dart';
import 'package:sige_ie/areas/feature/register/new_area.dart';
import 'package:sige_ie/equipments/feature/electrical-circuit/electricalCircuitList.dart';
import 'core/feature/login/login.dart';

void main() {
  runApp(const MyApp());
}

final cookieJar = CookieJar();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const SplashScreen());
          case '/loginScreen':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/first':
            return MaterialPageRoute(builder: (context) => const FirstScreen());
          case '/facilities':
            return MaterialPageRoute(
                builder: (context) => const FacilitiesPage());
          case '/registerScreen':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/homeScreen':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final int initialPage = args['initialPage'] ?? 0;
              return MaterialPageRoute(
                builder: (context) => HomePage(initialPage: initialPage),
              );
            }
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/MapsPage':
            return MaterialPageRoute(builder: (context) => const MapsPage());
          case '/newLocation':
            return MaterialPageRoute(builder: (context) => NewPlace());
          case '/arealocation':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? localName = args['placeName']?.toString();
              final int? localId = args['placeId'] as int?;

              if (localName != null && localId != null) {
                return MaterialPageRoute(
                  builder: (context) =>
                      AreaLocation(localName: localName, localId: localId),
                );
              } else {
                throw Exception(
                    'Invalid arguments: localName or localId is null in /arealocation.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /arealocation.');

          case '/systemLocation':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int? areaId = args['areaId'];
              if (areaName != null &&
                  localName != null &&
                  localId != null &&
                  areaId != null) {
                return MaterialPageRoute(
                    builder: (context) => SystemConfiguration(
                          areaName: areaName,
                          localName: localName,
                          localId: localId,
                          areaId: areaId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, localId, or areaId is null in /systemLocation.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /systemLocation.');

          case '/listIluminationEquipment':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listIluminationEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /equipmentScreen.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /equipmentScreen.');

          case '/electricalCircuitList':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listCicuitEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /electricalCircuitList.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /electricalCircuitList.');

          case '/electricalLineList':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listElectricalLineEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /electricalLineList.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /electricalLineList.');

          case '/listatmosphericEquipment':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;
              final int? areaId = args['areaId'];

              if (areaName != null &&
                  localName != null &&
                  localId != null &&
                  areaId != null) {
                return MaterialPageRoute(
                    builder: (context) => listatmosphericEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                          areaId: areaId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /electricalLineList.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /electricalLineList.');

          case '/listDistribuitionBoard':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listDistribuitionBoard(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /listDistribuitionBoard.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /listDistribuitionBoard.');

          case '/listFireAlarms':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int? areaId = args['areaId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null &&
                  localName != null &&
                  localId != null &&
                  areaId != null) {
                return MaterialPageRoute(
                  builder: (context) => listFireAlarms(
                    areaName: areaName,
                    categoryNumber: categoryNumber,
                    localName: localName,
                    localId: localId,
                    areaId: areaId,
                  ),
                );
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, localId, or areaId is null in /listFireAlarms.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /listFireAlarms.');

          case '/listCollingEquipment':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listCollingEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /listDistribuitionBoard.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /listDistribuitionBoard.');

          case '/listStruturedCabling':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listStruturedCabling(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /listStruturedCabling.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /listStruturedCabling.');

          case '/listelectricalLoadEquipment':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => listelectricalLoadEquipment(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /electricalLineList.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /electricalLineList.');

          default:
            return MaterialPageRoute(
                builder: (context) => UndefinedView(name: settings.name));
        }
      },
    );
  }
}

class UndefinedView extends StatelessWidget {
  final String? name;
  const UndefinedView({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('No route defined for ${name ?? "unknown"}')),
    );
  }
}
