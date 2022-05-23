import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CustomDivider(
      {this.height = 1, this.color = const Color.fromRGBO(207, 215, 219, 1)});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: 25,
      thickness: 1,
    );
  }
}
