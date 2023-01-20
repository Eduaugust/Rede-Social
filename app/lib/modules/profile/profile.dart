import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final idUser;
  dynamic decode = {
    'name': 1,
    'nameVisible': true,
    'userType': 'Pessoa',
    'email': 1,
    'emailVisible': true,
    'number': 1,
    'numberVisible': true
  };
  bool email = true;
  bool number = true;
  bool name = true;
  ProfilePage({
    Key? key,
    required this.idUser,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http
          .get(Uri.parse('http://localhost:3000/user/login/${widget.idUser}')),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var response = snapshot.data;
          widget.decode = json.decode(response!.body);
        }
        widget.email = widget.decode['emailVisible'];
        widget.name = widget.decode['nameVisible'];
        widget.number = widget.decode['numberVisible'];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Informações privadas"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email Privado'),
                  Switch(
                      value: widget.email,
                      onChanged: (value) async {
                        await http.put(
                          Uri.parse(
                              'http://localhost:3000/user/${widget.idUser}'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body:
                              jsonEncode(<String, bool>{"emailVisible": value}),
                        );
                        setState(() {
                          widget.email = value;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nome Privado'),
                  Switch(
                      value: widget.name,
                      onChanged: (value) async {
                        await http.put(
                          Uri.parse(
                              'http://localhost:3000/user/${widget.idUser}'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body:
                              jsonEncode(<String, bool>{"nameVisible": value}),
                        );
                        setState(() {
                          widget.name = value;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Número Privado'),
                  Switch(
                      value: widget.number,
                      onChanged: (value) async {
                        await http.put(
                          Uri.parse(
                              'http://localhost:3000/user/${widget.idUser}'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(
                              <String, bool>{"numberVisible": value}),
                        );
                        setState(() {
                          widget.number = value;
                        });
                      })
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
