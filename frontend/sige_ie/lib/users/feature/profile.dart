import 'package:flutter/material.dart';
import 'package:sige_ie/core/data/auth_service.dart';
import 'package:sige_ie/users/data/user_response_model.dart';
import 'package:sige_ie/users/data/user_service.dart';
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
        title: const Text(
          'Editar Perfil',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: TextEditingController(text: userResponseModel.email),
              onChanged: (value) => userResponseModel.email = value,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Nome'),
              controller:
                  TextEditingController(text: userResponseModel.firstname),
              onChanged: (value) => userResponseModel.firstname = value,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
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
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await userService.update(userResponseModel.id,
                          userResponseModel.firstname, userResponseModel.email);
                    },
                    child: const Text('Salvar',
                        style: TextStyle(
                            color: AppColors.dartText,
                            fontSize: 15,
                            fontWeight: FontWeight.w900)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 221, 221),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(140, 50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authService.logout();
                      Navigator.pushReplacementNamed(context, '/loginScreen');
                    },
                    child: const Text('Sair da Conta',
                        style: TextStyle(
                            color: AppColors.dartText,
                            fontSize: 15,
                            fontWeight: FontWeight.w900)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 153, 163, 168),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(140, 50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        // Mostrar o diálogo de confirmação
                        bool deleteConfirmed = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('EXCLUIR'),
                              content: const Text(
                                  'Tem certeza que deseja excluir sua conta?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        false); // Retorna falso para indicar que a exclusão não foi confirmada
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        true); // Retorna verdadeiro para indicar que a exclusão foi confirmada
                                  },
                                  child: const Text('Confirmar'),
                                ),
                              ],
                            );
                          },
                        );

                        // Se a exclusão for confirmada, exclua a conta
                        if (deleteConfirmed) {
                          await userService.delete(userResponseModel.id);
                          Navigator.pushReplacementNamed(
                              context, '/loginScreen');
                        }
                      },
                      child: const Text('Excluir Conta',
                          style: TextStyle(
                              color: AppColors.lightText,
                              fontSize: 15,
                              fontWeight: FontWeight.w900)),
                      style: AppButtonStyles.warnButton.copyWith(
                          minimumSize:
                              MaterialStateProperty.all(const Size(140, 50)))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
