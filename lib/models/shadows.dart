import 'package:flutter/material.dart';

class Shadows {
  final emptyBoxShadow = [
    BoxShadow(
      color: const Color(0x3C40434D).withOpacity(0.5),
      blurRadius: 1.0,
      spreadRadius: 1,
    ),
  ];

  final filledBoxShadow = [
    BoxShadow(
      color: const Color(0x3C40434D).withOpacity(0.25),
      blurRadius: 2.0,
      spreadRadius: 0,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: const Color(0x3C404326).withOpacity(0.15),
      blurRadius: 6.0,
      spreadRadius: 2,
      offset: const Offset(0, 2),
    ),
  ];

  get getEmptyBoxShadow => emptyBoxShadow;

  get getFilledBoxShadow => filledBoxShadow;
}
