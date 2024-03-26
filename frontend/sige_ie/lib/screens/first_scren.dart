import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff123c75),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centraliza no meio
          children: <Widget>[
            Image.asset('assets/1000x1000.png'), // Sua imagem
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/loginScreen'); // Navega para Login
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 6,
                    minimumSize: Size(200, 50),
                    backgroundColor: Color(0xfff1f60e),
                    foregroundColor: Color(0xff123c75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Arredondamento dos cantos do botão
                    ))),
            SizedBox(
              height: 15, // Espaço entre os botões
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/registerScreen'); // Navega para Registro
              },
              child: Text(
                "Registro",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 6,
                  minimumSize: Size(200, 50),
                  backgroundColor: Color(0xfff1f60e),
                  foregroundColor: Color(0xff123c75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Arredondamento dos cantos do botão
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
