import 'package:flutter/material.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/widgets.dart';

class DragAndDropWidget extends StatefulWidget {
  final String item;
  final GameButtonWidget gameButtonWidget;

  const DragAndDropWidget({
    Key? key,
    required this.item,
    required this.gameButtonWidget,
  }) : super(key: key);

  @override
  _DragAndDropWidgetState createState() => _DragAndDropWidgetState();
}

class _DragAndDropWidgetState extends State<DragAndDropWidget> {
  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: widget.item,
      feedback: Container(
        child: widget.gameButtonWidget,
      ),
      child: Container(
        child: widget.gameButtonWidget,
      ),
      childWhenDragging: GameButtonWidget(
        hidden: false,
        onButtonClicked: () {},
        color: CustomColors.gcEmpty.withOpacity(1),
      ),
    );
  }
}
