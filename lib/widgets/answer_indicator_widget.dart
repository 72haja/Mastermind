import 'package:flutter/material.dart';
import 'package:mastermind/models/shadows.dart';
import 'package:mastermind/theme/colors.dart';

class AnswerIndicatorWidget extends StatelessWidget {
  final Color color;

  AnswerIndicatorWidget({
    Key? key,
    required this.color,
    Function? callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.0,
      height: 5.0,
      decoration: BoxDecoration(
        color: color.withOpacity(1),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: Shadows().getFilledBoxShadow,
      ),
    );
  }
}
