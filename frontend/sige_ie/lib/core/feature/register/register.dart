import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sige_ie/users/data/user_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// Definição da classe da tela de Registro
class _RegisterScreenState extends State<RegisterScreen> {
  bool terms = true;
  final _registerScreen = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff123c75),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff123c75),
        ),
        body: Center(
          // Logo da Página e Seu Formato
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/1000x1000.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 6, // Configuração da página
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50.0))),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _registerScreen,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Registro', // Nome da Página de Registro
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black)),
                          const SizedBox(height: 35),
                          TextFormField(
                            controller: usernameController,
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
                              // Outras propriedades...
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um username válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Campo de nome e decoração da borda de inserção dos dados
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              label: const Text('Nome'),
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: 'Insira seu Nome',
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
                              // Outras propriedades...
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por Favor Insira seu Nome';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira um email valido';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                hintText: 'Insira o Email',
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
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por Favor, insira uma senha valida';
                              }
                              return null;
                            },
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
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value != passwordController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Confirmar Senha'),
                              labelStyle: const TextStyle(color: Colors.black),
                              hintText: 'Confirme sua senha',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(31, 255, 3, 3),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: terms,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          terms = value!;
                                        });
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 12, 78, 170)),
                                  const Text(
                                    'Aceite os Termos',
                                    style: TextStyle(
                                      color: const Color(0xff123c75),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_registerScreen.currentState!.validate()) {
                                  if (terms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Processando Dados'),
                                      ),
                                    );
                                    bool success = await UserService.register(
                                        usernameController.text,
                                        nameController.text,
                                        passwordController.text,
                                        emailController.text);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();

                                    if (success) {
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context)
                                          .pushReplacementNamed('/loginScreen');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Registro falhou, por favor tente novamente.'),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Por Favor, concorde com o processamento de dados pessoais'),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Registro',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                  elevation: 6,
                                  backgroundColor:
                                      Color.fromARGB(255, 244, 248, 0),
                                  foregroundColor: Color(0xff123c75),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Já tem uma conta? ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/loginScreen');
                                },
                                child: Text(
                                  'Fazer login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff123c75),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )),
                  ))
            ],
          ),
        ));
  }
}
