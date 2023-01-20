// ignore_for_file: depend_on_referenced_packages, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../minha_lista/list_item.dart';

class SearchBar extends StatefulWidget {
  String text = '';
  Function listVibility;
  var entradas = [];
  var pessoasFiltradas = [];
  final idUser;
  Function refreshPage;

  SearchBar({
    Key? key,
    required this.idUser,
    required this.listVibility,
    required this.refreshPage,
  }) : super(key: key);
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          TextField(
            onChanged: (value) async {
              widget.listVibility(value);

              getAll() async {
                var response = await http.get(
                    Uri.parse('http://localhost:3000/user/${widget.idUser}'));
                dynamic decode = json.decode(response.body);
                return decode;
              }

              var seila = await getAll();
              widget.entradas = seila;
              setState(() {
                widget.pessoasFiltradas = [];
                for (var element in widget.entradas) {
                  if (element['name'].contains(value)) {
                    widget.pessoasFiltradas.add(element);
                  } else if (element['email'].contains(value)) {
                    widget.pessoasFiltradas.add(element);
                  } else if (element['number'].contains(value)) {
                    widget.pessoasFiltradas.add(element);
                  }
                }
                widget.text = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'ex.: Nome, número, email',
              labelText: 'Adicionar nova relação',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          Visibility(
            visible: widget.text != '',
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: widget.pessoasFiltradas.length,
                itemBuilder: (_, index) => Column(children: [
                  ListItem(
                    addRelation: (String type) async {
                      var id = widget.pessoasFiltradas[index]['id'];
                      var response = await http.post(
                        Uri.parse('http://localhost:3000/user/connect'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          "id": widget.idUser,
                          "targetId": id,
                          "type": type
                        }),
                      );
                      widget.refreshPage();
                      dynamic decode = json.decode(response.body);
                      return decode;
                    },
                    name: widget.pessoasFiltradas[index]['name'],
                    email: widget.pessoasFiltradas[index]['email'],
                    number: widget.pessoasFiltradas[index]['number'],
                    type: widget.pessoasFiltradas[index]['userType'],
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
