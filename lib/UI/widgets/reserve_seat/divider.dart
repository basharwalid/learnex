import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Divider(color: Colors.black.withOpacity(0.07), height: 1);
}