import 'package:flutter/material.dart';

Widget sectionLabel(String text) => Text(
  text.toUpperCase(),
  style: TextStyle(
    fontSize: 11,
    letterSpacing: 1.1,
    fontWeight: FontWeight.w600,
    color: Colors.black.withOpacity(0.38),
  ),
);