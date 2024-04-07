import 'package:flutter/material.dart';

// Importe suas páginas personalizadas
import '../../users/feature/profile.dart';
import '../../screens/facilities.dart';
import '../../maps/feature/maps.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          Text(''), // Assumindo que esta é sua HomePage temporária
          FacilitiesPage(),
          MapsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
    );
  }
}
