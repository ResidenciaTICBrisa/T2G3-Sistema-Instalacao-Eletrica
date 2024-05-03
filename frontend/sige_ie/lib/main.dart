import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/core/ui/splash_screen.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/maps/feature/maps.dart';
import 'package:sige_ie/places/feature/manage/atmosphericDischarges.dart';
import 'package:sige_ie/places/feature/manage/fireAlarm.dart';
import 'package:sige_ie/places/feature/manage/lowVoltage.dart';
import 'package:sige_ie/places/feature/manage/structuredCabling.dart';
import 'package:sige_ie/places/feature/manage/systemConfiguration.dart';
import 'package:sige_ie/places/feature/register/new_place.dart';
import 'package:sige_ie/places/feature/register/room_state.dart';
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
            if (settings.arguments is String) {
              final localName = settings.arguments as String;
              return MaterialPageRoute(
                builder: (context) => RoomLocation(localName: localName),
              );
            }
            throw Exception(
                'Invalid route: Expected string argument for /roomlocation.');

          case '/systemLocation':
            if (settings.arguments is String) {
              final roomName = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (context) =>
                      SystemConfiguration(roomName: roomName));
            }
            throw Exception(
                'Invalid route: Expected string argument for /systemLocation.');
          case '/lowVoltage':
            return MaterialPageRoute(
                builder: (context) => const LowVoltageScreen(
                      roomName: '',
                    ));
          case '/structuredCabling':
            return MaterialPageRoute(
                builder: (context) => const StructuredCablingScreen(
                      roomName: '',
                    ));
          case '/atmosphericDischarges':
            return MaterialPageRoute(
                builder: (context) => const AtmosphericDischargesScreen(
                      roomName: '',
                    ));
          case '/fireAlarm':
            return MaterialPageRoute(
                builder: (context) => const FireAlarmScreen(
                      roomName: '',
                    ));
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
