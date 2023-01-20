// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class ListItem extends StatelessWidget {
  Function(String type) addRelation;
  String name;
  String email;
  String number;
  String type;
  ListItem({
    Key? key,
    required this.name,
    required this.email,
    required this.number,
    required this.type,
    required this.addRelation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppColors.stroke),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Column(children: [
                Text(name),
                Text(email),
              ]),
              const SizedBox(width: 15),
              Column(children: [
                Text(type),
                Text(number),
              ]),
              const Spacer(),
              if (type == 'Pessoa' || type == 'pessoa')
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 5, 5, 5)),
                  onPressed: () {
                    addRelation('Familia');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Familia"),
                ),
              if (type == 'Pessoa' || type == 'pessoa')
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 5, 5, 5)),
                  onPressed: () {
                    addRelation('Conhecido');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Conhecido"),
                ),
              if (type == 'Pessoa' || type == 'pessoa')
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 5, 5, 5)),
                  onPressed: () async {
                    await addRelation('Amigo');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Amigo"),
                ),
              if (type == 'Organizacao' || type == 'organizacao')
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 5, 5, 5)),
                  onPressed: () {
                    addRelation('Cliente');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Sou Cliente"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
