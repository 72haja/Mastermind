import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mastermind/models/fixed_btn_model.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/fixed_color_button_widget.dart';
import 'package:mastermind/widgets/widgets.dart';

import 'color_chose_box_widget.dart';
import 'color_chose_widget.dart';

class GameBoxWidget extends StatefulWidget {
  final List<Color> buttonColors;
  final List<FixedBtnModel> fixedBtns;

  Function(String) callback;

  void setButtonColor(int index, String color) {
    var tmpColor;
    switch (color) {
      case "yellow":
        tmpColor = CustomColors.gcYellow;
        break;
      case "orange":
        tmpColor = CustomColors.gcOrange;
        break;
      case "green":
        tmpColor = CustomColors.gcGreen;
        break;
      case "blue":
        tmpColor = CustomColors.gcBlue;
        break;
      case "grey":
        tmpColor = CustomColors.gcGrey;
        break;
      case "white":
        tmpColor = CustomColors.gcWhite;
        break;
      case "pink":
        tmpColor = CustomColors.gcPink;
        break;
      case "purple":
        tmpColor = CustomColors.gcPurple;
        break;
      default:
        tmpColor = CustomColors.gcEmpty;
    }
    buttonColors[index] = tmpColor;
    callback("CHANGE");
  }

  GameBoxWidget({
    Key? key,
    required this.buttonColors,
    required this.fixedBtns,
    required this.callback,
  }) : super(key: key);

  @override
  GameBox createState() => GameBox();
}

class GameBox extends State<GameBoxWidget> {
  List<bool> _shownButtons = [false, false, false, false, false];

  bool _gameIsFinished = false;

  List<int> row = [
    0,
    1,
    2,
    3,
    4,
  ];

  double getLeftSpacing(BuildContext context, bool element) {
    return ((40 + ((MediaQuery.of(context).size.width - 344) / 4)) *
        _shownButtons.indexOf(element));
  }

  void setGameToFinished() => setState(() {
        _gameIsFinished = true;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.backgroundLight.withOpacity(1),
        border: Border.all(
          width: 2.0,
          color: CustomColors.secondaryDark.withOpacity(1),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _gameIsFinished
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Gewonnen",
                            style: TextStyle(
                                fontSize: 40,
                                color: CustomColors.secondaryDark
                                    .withOpacity(1)),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Row(
                              children: [
                                for (var index in row) ...[
                                  DragTarget<String>(
                                    builder: (
                                      BuildContext context,
                                      List<dynamic> accepted,
                                      List<dynamic> rejected,
                                    ) {
                                      return GameButtonWidget(
                                        hidden: false,
                                        onButtonClicked: () {
                                          if (_shownButtons[
                                              index]) {
                                            _shownButtons[
                                                index] = false;
                                          } else {
                                            _shownButtons =
                                                List.filled(
                                                    _shownButtons
                                                        .length,
                                                    false,
                                                    growable:
                                                        true);

                                            _shownButtons[
                                                index] = true;
                                          }
                                          setState(() {});
                                        },
                                        color:
                                            widget.buttonColors[
                                                index],
                                      );
                                    },
                                    onWillAccept: (data) {
                                      return true;
                                    },
                                    onAccept: (data) {
                                      widget.setButtonColor(
                                          index, data);
                                    },
                                  ),
                                  if (index != 4) const Spacer(),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          Row(children: [
            ColorChoseBoxWidget(),
          ]),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 560,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: FixedColorWidgetState(
                            fixedBtns: widget.fixedBtns,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
