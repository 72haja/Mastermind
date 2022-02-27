import 'package:flutter/material.dart';
import 'package:mastermind/models/shadows.dart';
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

  Color get getColor => widget.hidden
      ? CustomColors.secondaryLight.withOpacity(1)
      : widget.color.withOpacity(1);

  List<BoxShadow> get getFilledBoxShadow =>
      gameColorIsEmpty ? Shadows().getEmptyBoxShadow : Shadows().getFilledBoxShadow;

  List<BoxShadow> get getBoxShadow =>
      widget.hidden ? Shadows().getFilledBoxShadow : getFilledBoxShadow;

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
