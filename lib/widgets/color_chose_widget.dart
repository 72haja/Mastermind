import 'package:flutter/material.dart';
import 'package:mastermind/theme/colors.dart';

import 'color_chose_button_widget.dart';

class ColorChoseWidget extends StatefulWidget {
  final Function(Color) onColorChosen;
  const ColorChoseWidget({
    Key? key,
    required this.onColorChosen,
  }) : super(key: key);

  @override
  _ColorChose createState() => _ColorChose();
}

class _ColorChose extends State<ColorChoseWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          height: 15,
          width: 15,
          left: 32.5,
          top: 0,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcYellow,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcYellow);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          right: 9,
          top: 9,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcOrange,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcOrange);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          left: 65,
          top: 32.5,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcGreen,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcGreen);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          right: 9,
          bottom: 9,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcBlue,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcBlue);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          left: 32.5,
          top: 65,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcGrey,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcGrey);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          left: 9,
          bottom: 9,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcWhite,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcWhite);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          left: 0,
          top: 32.5,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcPink,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcPink);
            },
          ),
        ),
        Positioned(
          height: 15,
          width: 15,
          left: 9,
          top: 9,
          child: ColorChoseButtonWidget(
            color: CustomColors.gcPurple,
            onButtonClicked: () {
              widget.onColorChosen(CustomColors.gcPurple);
            },
          ),
        ),
      ],
    );
  }
}
