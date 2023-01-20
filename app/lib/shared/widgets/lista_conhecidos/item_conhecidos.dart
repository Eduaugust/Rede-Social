// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class ItemConhecidos extends StatelessWidget {
  Function(String type) addRelation;
  String name;
  String email;
  String number;
  String type;
  String relationType;
  ItemConhecidos({
    Key? key,
    required this.name,
    required this.email,
    required this.number,
    required this.type,
    required this.addRelation,
    required this.relationType,
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
              const SizedBox(width: 15),
              Column(children: [
                Text(relationType),
              ]),
              const Spacer(),
              TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 5, 5, 5)),
                onPressed: () {
                  addRelation('Cliente');
                },
                icon: const Icon(Icons.remove_circle),
                label: const Text("Remover relação"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
