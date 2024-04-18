import 'package:flutter/material.dart';
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          buildHomePage(context),
          FacilitiesPage(),
          MapsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff123c75),
          elevation: 0,
        ),
        Container(
          color: Color(0xff123c75),
          height: MediaQuery.of(context).size.height * 0.30,
        ),
        Spacer(),
        buildSmallRectangle(context),
        buildSmallRectangle(context),
        Spacer(),
      ],
    );
  }

  Widget buildSmallRectangle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff123c75),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
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
        ),
      ),
    );
  }
}
