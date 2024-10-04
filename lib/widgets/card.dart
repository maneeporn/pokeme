import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String name;
  const CardItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
