import 'package:flutter/material.dart';
import 'package:sige_ie/core/data/auth_service.dart';
import 'package:sige_ie/users/data/user_model.dart';
import 'package:sige_ie/users/data/user_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserService userService = UserService();
  AuthService authService = AuthService();
  UserModel userModel =
      UserModel(id: '', email: '', firstname: '', username: '');

  @override
  void initState() {
    super.initState();
    userService.fetchProfileData().then((userModel) {
      setState(() {
        this.userModel = userModel;
      });
    }).catchError((error) {
      // Handle error
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: TextEditingController(text: userModel.email),
              onChanged: (value) => userModel.email = value,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              controller: TextEditingController(text: userModel.firstname),
              onChanged: (value) => userModel.firstname = value,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              controller: TextEditingController(text: userModel.username),
              enabled: false,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Mudar senha',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Mudar username',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () async {
                  await userService.update(
                      userModel.id, userModel.firstname, userModel.email);
                },
                child: Text('Salvar', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await authService.logout();
                  Navigator.pushReplacementNamed(context, '/loginScreen');
                },
                child: Text('Sair da Conta',
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[200],
                ),
              ),
            ]),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Mostrar o diálogo de confirmação
                    bool deleteConfirmed = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Excluir Conta'),
                          content:
                              Text('Tem certeza que deseja excluir sua conta?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Retorna falso para indicar que a exclusão não foi confirmada
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Retorna verdadeiro para indicar que a exclusão foi confirmada
                              },
                              child: Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );

                    // Se a exclusão for confirmada, exclua a conta
                    if (deleteConfirmed) {
                      await userService.delete(userModel.id);
                      Navigator.pushReplacementNamed(context, '/loginScreen');
                    }
                  },
                  child: Text('Excluir Conta',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
