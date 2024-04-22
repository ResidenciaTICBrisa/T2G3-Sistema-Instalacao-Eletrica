import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
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
          ProfilePage()
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
        Expanded(
          flex: 3, // Proporção ajustada para a imagem e o texto
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.sigeIeBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), // Bordas arredondadas embaixo
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/1000x1000.png'),
                        fit: BoxFit.cover, // Imagem cobrindo todo o espaço
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      left: 20), // Padding para alinhamento à esquerda
                  child: Text(
                    'Olá, ',
                    style: TextStyle(
                      color: AppColors.sigeIeYellow,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6, // Restante do conteúdo
          child: Column(
            children: [
              Spacer(),
              buildSmallRectangle(context, 'Registrar novo local', 'Registrar',
                  () {
                Navigator.of(context).pushNamed('/newLocation');
                print("Registrar novo local clicado");
              }),
              buildSmallRectangle(context, 'Gerenciar locais', 'Gerenciar', () {
                print("Gerenciar locais clicado");
              }),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSmallRectangle(BuildContext context, String text,
      String buttonText, VoidCallback onPress) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff123c75),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      height: 135, // Increased height to better accommodate vertical layout
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(20), // Adjusted padding for better spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align children to center horizontally
        children: [
          Text(
            text,
            textAlign: TextAlign.center, // Center-align the text
            style: TextStyle(
              color: Colors.white,
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.bold, // Bold font weight
            ),
          ),
          SizedBox(height: 10), // Space between text and button
          ElevatedButton(
            style: AppButtonStyles.standardButton,
            onPressed: onPress,
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16, // Font size for button text
                fontWeight: FontWeight.bold, // Bold font weight
              ),
            ),
          )
        ],
      ),
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
