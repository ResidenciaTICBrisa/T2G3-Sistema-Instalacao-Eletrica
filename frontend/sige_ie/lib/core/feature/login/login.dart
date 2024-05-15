import 'package:flutter/material.dart';
import 'package:sige_ie/core/data/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
// Instância do Serviço de Autenticação  e flag para lembrar o usuário e uma chave global para controlar o estado do formulário.
class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();
  bool rememberMe = false;
  final _loginScreen = GlobalKey<FormState>();
  //Controladores de Texto para campos de nome de usuário e senha.
  final TextEditingController usernameController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController();
  // Constroi a interface do Usuário para esta tela com a logo e toda configuração personalizada do aplicativo.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff123c75),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff123c75),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(// Container para mostrar uma imagem de logo ou capa
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/1000x1000.png'),// Logo Personalizada do aplicativo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(// Container que contém o formulário de login.
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50.0))),
                  child: SingleChildScrollView(
                      child: Form(
                    key: _loginScreen, // Chave do Fórnulario.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [    //Constroi o Fórmulario.
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 35), // Campo de Entrada do nome de Usuário.
                        TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um username válido';
                              }
                              return null;
                            },// Validação do nome do usuário  e configuração formulário.
                            decoration: InputDecoration(
                              label: const Text('Username'),
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: 'Insira o seu username',
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 39, 38, 38),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        const SizedBox(height: 20),
                        TextFormField(// Campo de entrada de senha do usuário.
                          controller: passwordController,
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira uma senha válida';
                            }
                            return null;
                          },// Validação de  Senha do usuário e configuraçao de fórmulário.
                          decoration: InputDecoration(
                            label: const Text('Senha'),
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Insira a senha',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(31, 255, 3, 3),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(// Widget para checkbox de lembrar usuário e link para esquecer senha.
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    value: rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                    activeColor:
                                        const Color.fromARGB(255, 12, 78, 170)),
                                const Text(
                                  'Manter conectado',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: const Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff123c75),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Rotina de Implementação e validação de autenticação do Login.
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_loginScreen.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processando dados')),
                                );

                                bool success = await authService.login(
                                    usernameController.text,
                                    passwordController.text);

                                //bool isAuth = await authService.checkAuthenticated();
                                //print(isAuth);

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                //Validado Login, direcionamento de rota para paǵina Home.
                                if (success) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/homeScreen');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Login falhou, verifique suas credenciais')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Por favor, preencha todos os campos')),
                                );
                              }
                            },
                            //Widget para o Botão de Login
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 6,
                                backgroundColor:
                                    const Color.fromARGB(255, 244, 248, 0),
                                foregroundColor: const Color(0xff123c75),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                          ),
                        ),
                        // Widget para Link de Registro,caso não tenha uma conta.
                        const SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Não tem uma conta? ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/registerScreen');
                                },
                                child: const Text(
                                  'Registre-se',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff123c75),
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}
