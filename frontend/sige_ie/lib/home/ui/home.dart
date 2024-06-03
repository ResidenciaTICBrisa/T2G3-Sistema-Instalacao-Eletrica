import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import '../../users/feature/profile.dart';
import '../../facilities/ui/facilities.dart';
import '../../maps/feature/maps.dart';
import 'package:sige_ie/users/data/user_response_model.dart';
import 'package:sige_ie/users/data/user_service.dart';

class HomePage extends StatefulWidget {
  final int initialPage;

  const HomePage({super.key, this.initialPage = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;
  late PageController _pageController;
  UserService userService = UserService();
  late UserResponseModel user;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
    userService.fetchProfileData().then((fetchedUser) {
      setState(() {
        user = fetchedUser;
      });
    });
  }

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
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: <Widget>[
              buildHomePage(context),
              const FacilitiesPage(),
              const MapsPage(),
              ProfilePage()
            ],
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return FutureBuilder<UserResponseModel>(
      future: userService.fetchProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar os dados'));
        } else if (snapshot.hasData) {
          var user = snapshot.data!;
          return Stack(
            children: [
              Column(
                children: [
                  AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xff123c75),
                    elevation: 0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.sigeIeBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/1000x1000.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Olá, ${user.firstname}',
                              style: const TextStyle(
                                color: AppColors.sigeIeYellow,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        const Spacer(),
                        buildSmallRectangle(
                            context, 'Registrar novo local', 'Registrar', () {
                          Navigator.of(context).pushNamed('/newLocation');
                        }),
                        buildSmallRectangle(context, 'Equipes', 'Gerenciar',
                            () {
                          // Código aqui.
                        }),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.info, color: Colors.white, size: 30),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:
                              const Text('Informações sobre o Projeto Sigeie'),
                          content: const SingleChildScrollView(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'A criação do aplicativo Sigeie foi um esforço colaborativo de uma equipe dedicada de profissionais, cada um trazendo sua expertise para garantir o sucesso do projeto. Aqui está uma descrição detalhada da participação de cada membro, conforme a organização da equipe:\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '1. Loana Nunes Velasco - Cliente do Projeto\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Loana, docente do curso de Engenharia de Energia, atuou como cliente do projeto. Ela foi responsável por validar as entregas, garantindo que as necessidades e expectativas dos usuários finais fossem claramente comunicadas à equipe.\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '2. Pedro Lucas - Desenvolvedor Backend (Engenharia de Software)\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Pedro Lucas foi responsável por codificar o backend e configurar a infraestrutura necessária para o funcionamento do aplicativo. Ele contou com a colaboração de Kauan Jose e Oscar de Brito para garantir que o backend fosse seguro e escalável.\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '3. Danilo de Melo Ribeiro - Desenvolvedor Frontend e UX Design (Engenharia de Software)\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Danilo trabalhou no desenvolvimento do frontend do aplicativo, codificando a interface e realizando a integração com o backend. Ele projetou a interface do usuário, criou protótipos e realizou entrevistas com os clientes para garantir que o design fosse intuitivo e atendesse às necessidades dos usuários. Ele colaborou com Ramires Rocha e Pedro Lucas para construir uma interface responsiva e interativa.\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '4. Oscar de Brito - Analista de Requisitos (Engenharia de Software)\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Oscar levantou os requisitos do projeto, gerenciou a documentação e validou as especificações com o cliente. Ele contou com a colaboração de Ramires Rocha e Pedro Lucas para garantir que todos os requisitos fossem compreendidos e implementados corretamente.\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '5. Kauan Jose - Colaborador Backend (Engenharia de Software)\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Kauan colaborou no desenvolvimento do backend, fornecendo suporte essencial para Pedro Lucas. Ele ajudou a configurar a infraestrutura e garantir que o backend funcionasse de maneira eficiente e segura.\n\n',
                                  ),
                                  TextSpan(
                                    text:
                                        '6. Ramires Rocha - Colaborador Frontend (Engenharia Eletrônica)\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        '- Ramires colaborou no desenvolvimento do frontend, fornecendo suporte para Danilo de Melo Ribeiro. Ele ajudou a implementar funcionalidades e garantir que a interface fosse responsiva e interativa.\n\n',
                                  ),
                                ],
                              ),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Fechar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Estado desconhecido'));
        }
      },
    );
  }

  Widget buildSmallRectangle(BuildContext context, String text,
      String buttonText, VoidCallback onPress) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff123c75),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      height: 135,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.sigeIeYellow),
                foregroundColor:
                    MaterialStateProperty.all(AppColors.sigeIeBlue),
                minimumSize: MaterialStateProperty.all(const Size(140, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
            onPressed: onPress,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
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
          selectedItemColor: const Color(0xFF123C75),
          unselectedItemColor: const Color.fromARGB(255, 145, 142, 142),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
