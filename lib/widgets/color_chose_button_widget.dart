import 'package:flutter/material.dart';
import 'package:mastermind/models/shadows.dart';
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
          boxShadow: Shadows().getFilledBoxShadow,
        ),
      ),
    );
  }
}
