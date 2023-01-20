import 'package:app/modules/graph_view/graph_view_page.dart';
import 'package:app/modules/profile/profile.dart';
import 'package:app/shared/widgets/lista_conhecidos/lista_conhecidos.dart';
import 'package:app/shared/widgets/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  bool isVisible = true;
  final user;
  HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página inicial'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(idUser: widget.user['id']),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 600,
                  child: SearchBar(
                    listVibility: (String value) {
                      setState(() {
                        widget.isVisible = value == '';
                      });
                    },
                    idUser: widget.user['id'],
                    refreshPage: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            Visibility(
              visible: widget.isVisible,
              child: ListaConhecidos(
                  idUser: widget.user['id'],
                  refreshPage: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                  pessoasFiltradas: const []),
            ),
            const SizedBox(width: 50),
            TextButton(
              onPressed: () async {
                Future fetchAdjList(String id) async {
                  var response = await http
                      .get(Uri.parse('http://localhost:3000/user/graph/$id'));
                  dynamic decode = json.decode(response.body);
                  return decode;
                }

                var graphData =
                    await fetchAdjList(widget.user['id'].toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GraphClusterViewPage(
                              graphData: graphData,
                            )));
              },
              child: const Text('Veja suas relações na forma de um grafo'),
            ),
          ],
        ),
      ),
    );
  }
}
