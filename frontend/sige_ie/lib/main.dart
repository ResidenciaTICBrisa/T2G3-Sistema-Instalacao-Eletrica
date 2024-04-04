import 'package:flutter/material.dart';
import 'package:sige_ie/screens/first_scren.dart';
import 'package:sige_ie/screens/register.dart';
import 'package:sige_ie/screens/splash_screen.dart';
import 'package:sige_ie/screens/home.dart';
import 'package:sige_ie/screens/facilities.dart';
import 'package:sige_ie/screens/maps.dart';
import 'package:sige_ie/screens/profile.dart';

import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // Defina a rota inicial
      routes: {
        '/': (context) => SplashScreen(), // Rota do splash screen
        '/loginScreen': (context) => LoginScreen(), // Rota da tela de login
        '/first': (context) => FirstScreen(),
        '/registerScreen': (context) => RegisterScreen(),
        '/homeScreen': (context) => HomePage(),
        '/facilitiesScreen': (context) => HomePage(),
        '/MapsPage': (context) => MapsPage(),
        '/profileScreen': (context) => HomePage()
      },
    );
  }
}
