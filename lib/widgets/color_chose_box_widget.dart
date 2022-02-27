import 'package:flutter/material.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/drag_and_drop.dart';
import 'package:mastermind/widgets/widgets.dart';

import 'game_button_widget.dart';

class ColorChoseBoxWidget extends StatelessWidget {
  ColorChoseBoxWidget({
    Key? key,
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

  List<ColorMap> topColorMap = [
    ColorMap("yellow", CustomColors.gcYellow.withOpacity(1)),
    ColorMap("orange", CustomColors.gcOrange.withOpacity(1)),
    ColorMap("green", CustomColors.gcGreen.withOpacity(1)),
    ColorMap("blue", CustomColors.gcBlue.withOpacity(1)),
  ];

  List<ColorMap> bottomColorMap = [
    ColorMap("grey", CustomColors.gcGrey.withOpacity(1)),
    ColorMap("white", CustomColors.gcWhite.withOpacity(1)),
    ColorMap("pink", CustomColors.gcPink.withOpacity(1)),
    ColorMap("purple", CustomColors.gcPurple.withOpacity(1)),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.backgroundLight.withOpacity(1),
          border: Border.all(
            color: CustomColors.secondaryDark.withOpacity(1),
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Column(
            children: [
              Row(
                children: [
                  for (var colorObj in topColorMap) ...[
                    DragAndDropWidget(
                      item: colorObj.colorName,
                      gameButtonWidget: GameButtonWidget(
                        size: 30.0,
                        hidden: false,
                        onButtonClicked: () {},
                        color: colorObj.color,
                      ),
                    ),
                    if (topColorMap.indexOf(colorObj) < 3) const Spacer(),
                  ]
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  for (var colorObj in bottomColorMap) ...[
                    DragAndDropWidget(
                      item: colorObj.colorName,
                      gameButtonWidget: GameButtonWidget(
                        size: 30.0,
                        hidden: false,
                        onButtonClicked: () {},
                        color: colorObj.color,
                      ),
                    ),
                    if (bottomColorMap.indexOf(colorObj) < 3) const Spacer(),
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorMap {
  final String colorName;
  final Color color;

  ColorMap(this.colorName, this.color);
}
