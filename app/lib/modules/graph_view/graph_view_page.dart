// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class GraphClusterViewPage extends StatefulWidget {
  dynamic graphData;
  GraphClusterViewPage({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  _GraphClusterViewPageState createState() => _GraphClusterViewPageState();
}

class _GraphClusterViewPageState extends State<GraphClusterViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                color: const Color.fromARGB(255, 252, 0, 0),
              ),
              SizedBox(width: 5),
              Text('Familia'),
              SizedBox(width: 50),
              Container(
                height: 15,
                width: 15,
                color: const Color.fromARGB(255, 4, 0, 255),
              ),
              SizedBox(width: 5),
              Text('Conhecido'),
              SizedBox(width: 50),
              Container(
                height: 15,
                width: 15,
                color: const Color.fromARGB(255, 216, 244, 54),
              ),
              SizedBox(width: 5),
              Text('Amigo'),
              SizedBox(width: 50),
              Container(
                height: 15,
                width: 15,
                color: const Color.fromARGB(255, 255, 0, 191),
              ),
              SizedBox(width: 5),
              Text('Cliente'),
              SizedBox(width: 50),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(8),
                  minScale: 0.001,
                  maxScale: 100,
                  child: GraphView(
                      graph: graph,
                      algorithm: builder,
                      paint: Paint()
                        ..color = Colors.green
                        ..strokeWidth = 1
                        ..style = PaintingStyle.fill,
                      builder: (Node node) {
                        // I can decide what widget should be shown here based on the id
                        var a = node.key!.value['name'].toString();
                        return rectangWidget(a);
                      })),
            ),
          ],
        ));
  }

  Widget rectangWidget(String? i) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: AppColors.blue, spreadRadius: 1),
          ],
        ),
        child: Text(
          '$i',
        ));
  }

  final Graph graph = Graph();
  late Algorithm builder;

  @override
  void initState() {
    super.initState();
    Map<dynamic, Node> connectsByName = {};
    Map<dynamic, Node> connectsById = {};
    List nodesId = [];
    for (var element in widget.graphData['allNodes'] as List) {
      final node = Node.Id(element);
      nodesId.add(node);
      connectsByName[element['name'].toString()] = node;
      connectsById[element['id'].toString()] = node;
    }

    for (var element in widget.graphData['connects'] as List) {
      var name = element['name'];
      for (var i = 0; i < element['adj'].length; i++) {
        var adj = element['adj'][i];
        var tipo = element['type'][i];
        Paint cor;
        if (tipo == 'Familia') {
          cor = Paint()..color = const Color.fromARGB(255, 252, 0, 0);
        } else if (tipo == 'Conhecido') {
          cor = Paint()..color = const Color.fromARGB(255, 4, 0, 255);
        } else if (tipo == 'Amigo') {
          cor = Paint()..color = const Color.fromARGB(255, 216, 244, 54);
        } else {
          cor = Paint()..color = const Color.fromARGB(255, 255, 0, 191);
        }
        graph.addEdge(connectsByName[name]!, connectsById[adj.toString()]!,
            paint: cor);
      }
    }

    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }
}
