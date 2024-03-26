import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginScreen = GlobalKey<FormState>();
  bool rememberPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff123c75),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff123c75),
      ),
      body: Center(
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
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50.0))),
                  child: SingleChildScrollView(
                      child: Form(
                    key: _loginScreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 35),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um username válido';
                              }
                              return null;
                            },
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
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira uma senha válida';
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
                                    value: rememberPass,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPass = value!;
                                      });
                                    },
                                    activeColor:
                                        Color.fromARGB(255, 12, 78, 170)),
                                const Text(
                                  'Manter conectado',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff123c75),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_loginScreen.currentState!.validate() &&
                                  rememberPass) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processando dados'),
                                  ),
                                );
                              } else if (!rememberPass) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Por favor, concorde com o processamento de dados pessoais')),
                                );
                              }
                            },
                            child: const Text(
                              'Login',
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
                                'Não tem uma conta? ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/registerScreen');
                                },
                                child: Text(
                                  'Registre-se',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff123c75),
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
