import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_screen/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/places/register%20/register_new_location.dart';
import 'package:sige_ie/screens/splash_screen.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/screens/facilities.dart';
import 'package:sige_ie/maps/feature/maps.dart';
import 'package:sige_ie/users/feature/profile.dart';
import 'core/feature/login/login.dart';

void main() {
  runApp(MyApp());
}

final cookieJar = CookieJar();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/first': (context) => FirstScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/homeScreen': (context) => HomePage(),
        '/facilitiesScreen': (context) => HomePage(),
        '/MapsPage': (context) => MapsPage(),
        '/profileScreen': (context) => HomePage(),
        '/newLocation': (context) => newLocation(),
      },
    );
  }
}
