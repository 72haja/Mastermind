import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FixedBtnModel {
  final List<bool> correctColors;
  final List<bool> correctPositions;
  final List<Color> fixedBtns;

  FixedBtnModel(this.correctColors, this.correctPositions, this.fixedBtns);

  get getCorrectColors => correctColors;

  get getCorrectPositions => correctPositions;

  get getFixedBtns => fixedBtns;
}
