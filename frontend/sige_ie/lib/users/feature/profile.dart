import 'package:flutter/material.dart';
import 'package:sige_ie/core/data/auth_service.dart';
import 'package:sige_ie/users/models/user_response_model.dart';
import 'package:sige_ie/users/services/user_service.dart';
import 'package:sige_ie/config/app_styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserService userService = UserService();
  AuthService authService = AuthService();
  UserResponseModel userResponseModel =
      UserResponseModel(id: '', email: '', firstname: '', username: '');

  @override
  void initState() {
    super.initState();
    userService.fetchProfileData().then((userResponseModel) {
      setState(() {
        this.userResponseModel = userResponseModel;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.sigeIeBlue,
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.sigeIeBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: const Center(
              child: Column(
                children: [
                  Text(
                    'Editar perfil',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10), // Espaço adicional abaixo do texto
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      isDense: true,
                    ),
                    controller:
                        TextEditingController(text: userResponseModel.email),
                    onChanged: (value) => userResponseModel.email = value,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Nome',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      isDense: true,
                    ),
                    controller: TextEditingController(
                        text: userResponseModel.firstname),
                    onChanged: (value) => userResponseModel.firstname = value,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Username',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      isDense: true,
                    ),
                    controller:
                        TextEditingController(text: userResponseModel.username),
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Mudar senha',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Mudar username',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                      child: Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await userService.update(
                                userResponseModel.id,
                                userResponseModel.firstname,
                                userResponseModel.email);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.sigeIeYellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(150, 50),
                          ),
                          child: const Text('Salvar',
                              style: TextStyle(
                                  color: AppColors.sigeIeBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                await authService.logout();
                                Navigator.pushReplacementNamed(
                                    context, '/loginScreen');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(207, 231, 27, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(150, 50),
                              ),
                              child: const Text('Sair da Conta',
                                  style: TextStyle(
                                      color: AppColors.lightText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool deleteConfirmed = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('EXCLUIR'),
                                      content: const Text(
                                          'Tem certeza que deseja excluir sua conta?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pop(
                                                  false), // Retorna falso para indicar que a exclusão não foi confirmada
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pop(
                                                  true), // Retorna verdadeiro para indicar que a exclusão foi confirmada
                                          child: const Text('Confirmar'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Se a exclusão for confirmada, exclua a conta
                                if (deleteConfirmed) {
                                  await userService
                                      .delete(userResponseModel.id);
                                  Navigator.pushReplacementNamed(
                                      context, '/loginScreen');
                                }
                              },
                              style: AppButtonStyles.warnButton.copyWith(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(150, 50))),
                              child: const Text('Excluir Conta',
                                  style: TextStyle(
                                      color: AppColors.lightText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              )),
        ])));
  }
}
