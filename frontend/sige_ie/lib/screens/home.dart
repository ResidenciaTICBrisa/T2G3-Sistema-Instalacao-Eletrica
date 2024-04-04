import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Text('Home'),
    Text('Instalações'),
    Text('Mapa'),
    Text('Perfil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('App de Navegação'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            // Opcional: adicione uma sombra para um efeito elevado
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home, size: 35),
                    label: 'Home',
                    backgroundColor: Color(0xFFF1F60E)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.build, size: 35),
                    label: 'Instalações',
                    backgroundColor: Color(0xFFF1F60E)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map, size: 35),
                    label: 'Mapa',
                    backgroundColor: Color(0xFFF1F60E)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 35),
                    label: 'Perfil',
                    backgroundColor: Color(0xFFF1F60E)),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xFF123C75),
              unselectedItemColor: const Color.fromARGB(255, 145, 142, 142),
              onTap: _onItemTapped,
              selectedLabelStyle: TextStyle(
                color: Color(0xFF123C75),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
