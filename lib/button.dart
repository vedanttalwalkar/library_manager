import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String name;
  final Widget route;
  const Button({super.key, required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return route;
          }));
        },
        child: Text(name));
  }
}
