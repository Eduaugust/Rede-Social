// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/register/register_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '', senha = '';
    return Scaffold(
      appBar: AppBar(title: const Text("Livro de rosto")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Spacer(),
              SizedBox(
                width: 300,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        onSaved: (String? val) {
                          email = val!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        onSaved: (String? val) {
                          senha = val!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com uma senha';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  Future auth(
                                      String email, String senha) async {
                                    var response = await http.post(
                                      Uri.parse(
                                          'http://localhost:3000/user/auth'),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        "email": email,
                                        "password": senha
                                      }),
                                    );
                                    dynamic decode = json.decode(response.body);
                                    return decode;
                                  }

                                  var login = await auth(email, senha);
                                  if (login['id'].runtimeType == int) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          user: login,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Ocorreu algum erro \n${login['message'] as String}')),
                                    );
                                  }
                                }
                              },
                              child: const Text('Entrar'),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text('Cadastrar')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
