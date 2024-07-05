import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6399BE),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/UNB.png'),
            Image.asset('assets/1000x1000Horizontal.png'),
            const SizedBox(
              height: 140,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginScreen');
              },
              style: ElevatedButton.styleFrom(
                elevation: 6,
                minimumSize: const Size(200, 50),
                backgroundColor: const Color(0xfff1f60e),
                foregroundColor: const Color(0xff123c75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerScreen');
              },
              style: ElevatedButton.styleFrom(
                elevation: 6,
                minimumSize: const Size(200, 50),
                backgroundColor: const Color(0xfff1f60e),
                foregroundColor: const Color(0xff123c75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Registro",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
