// ignore_for_file: depend_on_referenced_packages, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:app/shared/widgets/lista_conhecidos/item_conhecidos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ListaConhecidos extends StatefulWidget {
  var pessoasFiltradas;
  final idUser;
  final refreshPage;
  ListaConhecidos({
    Key? key,
    required this.idUser,
    required this.refreshPage,
    required this.pessoasFiltradas,
  }) : super(key: key);

  @override
  State<ListaConhecidos> createState() => _ListaConhecidosState();
}

class _ListaConhecidosState extends State<ListaConhecidos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http
            .get(Uri.parse('http://localhost:3000/user/adj/${widget.idUser}')),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var response = snapshot.data;
            widget.pessoasFiltradas = json.decode(response!.body);
            return SizedBox(
              height: 350,
              child: (ListView.builder(
                itemCount: widget.pessoasFiltradas.length,
                itemBuilder: (_, index) => Column(children: [
                  ItemConhecidos(
                    addRelation: (String type) async {
                      var id = widget.pessoasFiltradas[index]['id'];
                      var response = await http.delete(
                        Uri.parse(
                            'http://localhost:3000/user/${widget.idUser}/$id'),
                      );
                      widget.refreshPage();
                      dynamic decode = json.decode(response.body);
                      return decode;
                    },
                    name: widget.pessoasFiltradas[index]['name'],
                    email: widget.pessoasFiltradas[index]['email'],
                    number: widget.pessoasFiltradas[index]['number'],
                    type: widget.pessoasFiltradas[index]['userType'],
                    relationType: widget.pessoasFiltradas[index]
                        ['relationType'],
                  )
                ]),
              )),
            );
          } else {
            return const Text('Carregando...');
          }
        }));
  }
}
