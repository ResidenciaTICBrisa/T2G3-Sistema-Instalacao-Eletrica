import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:sige_ie/core/ui/first_scren.dart';
import 'package:sige_ie/core/feature/register/register.dart';
import 'package:sige_ie/core/ui/splash_screen.dart';
import 'package:sige_ie/home/ui/home.dart';
import 'package:sige_ie/maps/feature/maps.dart';
import 'package:sige_ie/core/feature/manage/EquipmentScreen.dart';
import 'package:sige_ie/core/feature/manage/lowVoltage.dart';
import 'package:sige_ie/core/feature/manage/systemConfiguration.dart';
import 'package:sige_ie/places/feature/register/new_place.dart';
import 'package:sige_ie/areas/feature/register/new_area.dart';
import 'core/feature/login/login.dart';

//Função principal que inicializa o aplicativo.
void main() {
  runApp(const MyApp());
}
// Instância global de gerenciador de cookies.
final cookieJar = CookieJar();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) { //Switch case para determinar qual tela carregar com base nas rotas.
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/loginScreen':     // Tela de login.
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/first':           //Primeira Tela após o login.
            return MaterialPageRoute(builder: (context) => FirstScreen());
          case '/registerScreen':  //Tela de Registro.
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/homeScreen':     //Tela Home principal após o login.
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/MapsPage':       //Tela de Visualização do Mapa.
            return MaterialPageRoute(builder: (context) => MapsPage());
          case '/newLocation':    // Tela de Registro de um local ou area.
            return MaterialPageRoute(builder: (context) => NewPlace());
          case '/arealocation':  // Tela para gerenciar uma area ou local especifico.
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

          case '/systemLocation': //Tela para Configurar Sistema com base em local e area específico e verificação das informações fornecidas.
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => SystemConfiguration(
                          areaName: areaName,
                          localName: localName,
                          localId: localId,
                          categoryNumber: 0,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /systemLocation.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /systemLocation.');
          case '/lowVoltage': // Tela para configurar sistemas de baixa tensão com base no parâmetros assinalados e verificação das informações fornecidas.
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => LowVoltageScreen(
                          areaName: areaName,
                          localName: localName,
                          localId: localId,
                          categoryNumbers: const [],
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /lowVoltage.');
              }
            }
            throw Exception(
                'Invalid route: Expected Map arguments for /lowVoltage.');

          case '/equipamentScreen': //Tela para gerenciamento de equipamento em uma localidade específica e verificação  das informações fornecidas.
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? areaName = args['areaName']?.toString();
              final String? localName = args['localName']?.toString();
              final int? localId = args['localId'];
              final int categoryNumber = args['categoryNumber'] ?? 0;

              if (areaName != null && localName != null && localId != null) {
                return MaterialPageRoute(
                    builder: (context) => EquipmentScreen(
                          areaName: areaName,
                          categoryNumber: categoryNumber,
                          localName: localName,
                          localId: localId,
                        ));
              } else {
                throw Exception(
                    'Invalid arguments: One of areaName, localName, or localId is null in /equipamentScreen.');
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
// Tela padrão para visualização de uma rota que não esta definida.
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
