import 'package:flutter/material.dart';
import 'package:mastermind/theme/colors.dart';

class ColorChoseButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback onButtonClicked;

  ColorChoseButtonWidget({
    Key? key,
    this.color = CustomColors.gcEmpty,
    required this.onButtonClicked,
    Function? callback,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { onButtonClicked()},
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: color.withOpacity(1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: filledBoxShadow,
        ),
      ),
    );
  }
}
