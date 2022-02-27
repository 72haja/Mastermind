import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../theme/colors.dart';

class GameButtonWidget extends StatefulWidget {
  final Color color;
  bool hidden;
  final double? size;

  final VoidCallback onButtonClicked;

  GameButtonWidget({
    Key? key,
    this.color = CustomColors.gcEmpty,
    required this.hidden,
    this.size,
    required this.onButtonClicked,
    Function? callback,
  }) : super(key: key);

  @override
  State<GameButtonWidget> createState() => GameButtonWidgetState();
}

class GameButtonWidgetState extends State<GameButtonWidget> {
  void toggleHidden() {
    widget.hidden = !widget.hidden;
    setState(() {});
  }

  bool get gameColorIsEmpty =>
      widget.color == CustomColors.gcEmpty.withOpacity(1);

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

  Color get getColor => widget.hidden
      ? CustomColors.secondaryLight.withOpacity(1)
      : widget.color.withOpacity(1);

  List<BoxShadow> get getFilledBoxShadow =>
      gameColorIsEmpty ? emptyBoxShadow : filledBoxShadow;

  List<BoxShadow> get getBoxShadow =>
      widget.hidden ? filledBoxShadow : getFilledBoxShadow;

  get btnSize => widget.size ?? 40.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onButtonClicked(),
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(
          color: getColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: getBoxShadow,
        ),
        child: widget.hidden
            ? Icon(
                MdiIcons.lockQuestion,
                color: CustomColors.secondaryDark.withOpacity(1),
              )
            : null,
      ),
    );
  }
}
