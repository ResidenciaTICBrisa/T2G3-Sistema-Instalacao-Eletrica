import 'package:flutter/material.dart';
import 'package:sige_ie/core/data/auth_service.dart';
import 'package:sige_ie/users/data/user_response_model.dart';
import 'package:sige_ie/users/data/user_service.dart';
import 'package:sige_ie/config/app_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      UserResponseModel profileData = await userService.fetchProfileData();
      setState(() {
        userResponseModel = profileData;
      });
    } catch (error) {
      print(error);
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Editar dados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Nome'),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    isDense: true,
                  ),
                  controller:
                      TextEditingController(text: userResponseModel.firstname),
                  onChanged: (value) => userResponseModel.firstname = value,
                ),
                const SizedBox(height: 15),
                Text('Username'),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    isDense: true,
                  ),
                  controller:
                      TextEditingController(text: userResponseModel.username),
                  enabled: false,
                ),
                const SizedBox(height: 15),
                Text('Email'),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    isDense: true,
                  ),
                  controller:
                      TextEditingController(text: userResponseModel.email),
                  onChanged: (value) => userResponseModel.email = value,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Implementar lógica para mudar senha
                      },
                      child: const Text(
                        'Mudar senha',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Implementar lógica para mudar username
                      },
                      child: const Text(
                        'Mudar username',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await userService.update(
                    userResponseModel.id,
                    userResponseModel.firstname,
                    userResponseModel.email,
                  );
                  Navigator.of(context).pop();
                  _loadProfileData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sigeIeYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    color: AppColors.sigeIeBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.sigeIeBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: const BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Text(
                      'Perfil',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
                    'Olá, seja bem vindo',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userResponseModel.firstname,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.black),
                    title: Text(
                      'Editar dados',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: _showEditDialog,
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                  Divider(color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: AppColors.accent),
                    title: Text('Sair', style: TextStyle(color: Colors.black)),
                    onTap: () async {
                      await authService.logout();
                      Navigator.pushReplacementNamed(context, '/loginScreen');
                    },
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                  Divider(color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.delete, color: AppColors.warn),
                    title: Text(
                      'Excluir conta',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () async {
                      bool deleteConfirmed = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('EXCLUIR'),
                            content: const Text(
                              'Tem certeza que deseja excluir sua conta?',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Confirmar'),
                              ),
                            ],
                          );
                        },
                      );

                      if (deleteConfirmed) {
                        await userService.delete(userResponseModel.id);
                        Navigator.pushReplacementNamed(context, '/loginScreen');
                      }
                    },
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
