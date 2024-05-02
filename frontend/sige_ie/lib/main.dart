import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/core/ui/splash_screen.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/maps/feature/maps.dart';
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
      routes: {
        '/': (context) => SplashScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/first': (context) => FirstScreen(),
        '/registerScreen': (context) => const RegisterScreen(),
        '/homeScreen': (context) => HomePage(),
        '/facilitiesScreen': (context) => HomePage(),
        '/MapsPage': (context) => MapsPage(),
        '/profileScreen': (context) => HomePage(),
        '/newLocation': (context) => NewPlace(),
        '/roomlocation': (context) => RoomLocation(),
        '/systemLocation': (context) => SystemConfiguration(),
      },
    );
  }
}
