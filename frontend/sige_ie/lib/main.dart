import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/core/ui/splash_screen.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/maps/feature/maps.dart';
import 'package:sige_ie/places/feature/manage/EquipmentScreen.dart';
import 'package:sige_ie/places/feature/manage/lowVoltage.dart';
import 'package:sige_ie/places/feature/manage/systemConfiguration.dart';
import 'package:sige_ie/places/feature/register/new_place.dart';
import 'package:sige_ie/places/feature/register/new_area.dart';
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
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/loginScreen':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/first':
            return MaterialPageRoute(builder: (context) => FirstScreen());
          case '/registerScreen':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/homeScreen':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/MapsPage':
            return MaterialPageRoute(builder: (context) => MapsPage());
          case '/newLocation':
            return MaterialPageRoute(builder: (context) => NewPlace());
          case '/roomlocation':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? localName = args['placeName']?.toString();
              final int? localId = args['placeId'] as int?;

              if (localName != null && localId != null) {
                return MaterialPageRoute(
                  builder: (context) =>
                      RoomLocation(localName: localName, localId: localId),
                );
              } else {
                throw Exception(
                    'Invalid arguments: localName or localId is null in /roomlocation.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /roomlocation.');

          case '/systemLocation':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? roomName = args['roomName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              if (roomName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => SystemConfiguration(
                          roomName: roomName,
                          localName: localName,
                          localId: localId,
                          categoryNumber: 0,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of roomName, localName, or localId is null in /systemLocation.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /systemLocation.');
          case '/lowVoltage':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? roomName = args['roomName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (roomName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => LowVoltageScreen(
                          roomName: roomName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of roomName, localName, or localId is null in /lowVoltage.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /lowVoltage.');

          case '/equipamentScreen':
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? roomName = args['roomName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (roomName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => EquipmentScreen(
                          roomName: roomName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of roomName, localName, or localId is null in /equipamentScreen.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /equipamentScreen.');

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
  const UndefinedView({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('No route defined for ${name ?? "unknown"}')),
    );
  }
}
