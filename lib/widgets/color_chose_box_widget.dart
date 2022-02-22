import 'package:flutter/material.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/drag_and_drop.dart';
import 'package:mastermind/widgets/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.backgroundLight.withOpacity(1),
          border: Border(
            top: BorderSide(
              width: 2,
              color: CustomColors.secondaryDark.withOpacity(1),
            ),
            bottom: BorderSide(
              width: 2,
              color: CustomColors.secondaryDark.withOpacity(1),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Column(
            children: [
              Row(
                children: [
                  DragAndDropWidget(
                    item: "yellow",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcYellow.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "orange",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcOrange.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "green",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcGreen.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "blue",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcBlue.withOpacity(1),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  DragAndDropWidget(
                    item: "grey",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcGrey.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "white",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcWhite.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "pink",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcPink.withOpacity(1),
                    ),
                  ),
                  const Spacer(),
                  DragAndDropWidget(
                    item: "purple",
                    gameButtonWidget: GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: CustomColors.gcPurple.withOpacity(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
