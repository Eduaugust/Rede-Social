// ignore_for_file: use_build_context_synchronously, must_be_immutable, depend_on_referenced_packages

import 'package:app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  bool isPessoa = true;

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = '', senha = '', number = '', name = '';
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
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Número',
                        ),
                        onSaved: (String? val) {
                          number = val!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um número';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        onSaved: (String? val) {
                          name = val!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um nome';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          const Text('Organização'),
                          Switch(
                              value: widget.isPessoa,
                              onChanged: (val) {
                                setState(() {
                                  widget.isPessoa = val;
                                });
                              }),
                          const Text('Pessoa'),
                        ],
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
                                          'http://localhost:3000/user/register'),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        "email": email,
                                        "number": number,
                                        "password": senha,
                                        "name": name,
                                        "userType": widget.isPessoa
                                            ? 'Pessoa'
                                            : 'Organizacao'
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
                              child: const Text('Cadastrar'),
                            ),
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
