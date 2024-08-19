import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';
import 'package:sige_ie/users/data/user_response_model.dart';
import 'package:sige_ie/users/data/user_service.dart';
import 'package:sige_ie/users/data/username_request_model.dart';

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({super.key});

  @override
  _ChangeUsernameScreenState createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final UserService userService = UserService();
  final TextEditingController usernameController = TextEditingController();

  late UserResponseModel userResponseModel;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final fetchedUser = await userService.fetchProfileData();
      setState(() {
        userResponseModel = fetchedUser;
        usernameController.text = userResponseModel.username;
      });
    } catch (error) {
      // Tratamento de erro, pode-se exibir um dialog ou um Snackbar aqui
      print('Erro ao carregar dados do usuário: $error');
    }
  }

  Future<void> _changeUsername() async {
    final newUsername = usernameController.text.trim();
    if (newUsername.isEmpty) {
      _showSnackBar('O nome de usuário não pode estar vazio.');
      return;
    }

    try {
      final usernameRequestModel = UsernameRequestModel(username: newUsername);
      bool success = await userService.changeUsername(usernameRequestModel);
      if (success) {
        _showSnackBar('Usuário alterado com sucesso. Entre novamente.');
        Navigator.pushReplacementNamed(context, '/loginScreen');
      } else {
        _showSnackBar('Falha ao alterar o username.');
      }
    } catch (error) {
      // Tratamento de erro, pode-se exibir um dialog ou um Snackbar aqui
      _showSnackBar('Erro ao alterar nome de usuário.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUsernameTextField(),
                      ),
                      const SizedBox(width: 10),
                      _buildSaveButton(),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildBackButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: const BoxDecoration(
        color: AppColors.sigeIeBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: const Center(
        child: Text(
          'Mudar Usuário',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return TextField(
      controller: usernameController,
      enabled: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        isDense: true,
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _changeUsername,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.sigeIeYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(150, 50),
      ),
      child: const Text(
        'Salvar',
        style: TextStyle(
          color: AppColors.sigeIeBlue,
          fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Center(
      child: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(207, 231, 27, 27),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            'Voltar',
            style: TextStyle(
              color: AppColors.lightText,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
