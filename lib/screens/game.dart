import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/models/fixed_btn_model.dart';
import 'package:mastermind/models/user_model.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/game_box_widget.dart';
import 'package:mastermind/widgets/stop_watch.dart';
import 'package:mastermind/widgets/widgets.dart';
import 'package:provider/provider.dart';
import "dart:math";

class GameStatefulWidget extends StatefulWidget {
  final List<Color> allColors = [
    CustomColors.gcOrange,
    CustomColors.gcYellow,
    CustomColors.gcGreen,
    CustomColors.gcBlue,
    CustomColors.gcGrey,
    CustomColors.gcWhite,
    CustomColors.gcPink,
    CustomColors.gcPurple,
  ];

  GameStatefulWidget({Key? key}) : super(key: key);

  @override
  State<GameStatefulWidget> createState() => _GameStatefulWidgetState();
}

class _GameStatefulWidgetState extends State<GameStatefulWidget> {
  late TextEditingController _controllerUserName;
  late TextEditingController _controllerPassword;

  late List<GameButtonWidget> hiddenChilds;

  late String _gameState;

  final GlobalKey<StopWatchWidgetState> _keyStopWatchWidget = GlobalKey();
  final GlobalKey<GameBox> _keyGameBoxState = GlobalKey();
  List<GlobalKey<GameButtonWidgetState>> hiddenGameButtonKeys = [];

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
    _controllerPassword = TextEditingController();
    hiddenChilds = getHiddenChilds();
    _gameState = "started";
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  callback(index) {
    setState(() {});
  }

  List<GameButtonWidget> getHiddenChilds() {
    List<GameButtonWidget> hiddenChilds = [];
    List<Color> allColorsSuffled = (widget.allColors..shuffle());

    List.generate(
      5,
      (index) => {hiddenGameButtonKeys.add(GlobalKey())},
    );

    hiddenGameButtonKeys.asMap().forEach((index, key) => {
          hiddenChilds.add(GameButtonWidget(
            key: key,
            hidden: true,
            onButtonClicked: () {},
            color: allColorsSuffled[index].withOpacity(1),
          )),
        });

    return hiddenChilds;
  }

  List<bool> getCorrectColors() {
    List<bool> correctColors = [];

    hiddenChilds.map((e) => e.color.withOpacity(0)).forEach((color) {
      if (_buttonColors.contains(color)) {
        correctColors.add(true);
      } else {
        correctColors.add(false);
      }
    });

    correctColors.sort((a, b) {
      if (b) {
        return 1;
      }
      return -1;
    });
    return correctColors;
  }

  List<bool> getCorrectPositions() {
    List<bool> correctPositions = [];

    List<Color> hiddenChildsColors =
        hiddenChilds.map((e) => e.color.withOpacity(0)).toList();

    for (var i = 0; i < hiddenChildsColors.length; i++) {
      correctPositions.add(hiddenChildsColors[i] == _buttonColors[i]);
    }

    correctPositions.sort((a, b) {
      if (b) {
        return 1;
      }
      return -1;
    });

    if (!correctPositions.contains(false)) {
      for (var key in hiddenGameButtonKeys) {
        key.currentState?.toggleHidden();
      }
      _gameState = "finished";
      var time = _keyStopWatchWidget.currentState?.stopTimer();
      _keyGameBoxState.currentState?.setGameToFinished();

      saveGameStats(int.parse(time!));

      setState(() {});
    }

    return correctPositions;
  }

  List<Color> _buttonColors = [
    CustomColors.gcEmpty.withOpacity(1),
    CustomColors.gcEmpty.withOpacity(1),
    CustomColors.gcEmpty.withOpacity(1),
    CustomColors.gcEmpty.withOpacity(1),
    CustomColors.gcEmpty.withOpacity(1)
  ];

  void resetButtonColors() => _buttonColors = [
        CustomColors.gcEmpty.withOpacity(1),
        CustomColors.gcEmpty.withOpacity(1),
        CustomColors.gcEmpty.withOpacity(1),
        CustomColors.gcEmpty.withOpacity(1),
        CustomColors.gcEmpty.withOpacity(1)
      ];

  bool get containsEmpty =>
      _buttonColors.contains(CustomColors.gcEmpty.withOpacity(1));

  List<FixedBtnModel> fixedBtnsArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spiel'),
      ),
      body: Container(
        color: CustomColors.backgroundLight.withOpacity(1),
        child: Center(
          child: MergeSemantics(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StopWatchWidget(key: _keyStopWatchWidget),
                  HiddenBoxWidget(
                    childs: hiddenChilds,
                  ),
                  GameBoxWidget(
                    key: _keyGameBoxState,
                    buttonColors: _buttonColors,
                    fixedBtns: fixedBtnsArray,
                    callback: callback,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                if (!containsEmpty) {
                                  List<bool> correctColors = getCorrectColors();
                                  List<bool> correctPositions =
                                      getCorrectPositions();

                                  fixedBtnsArray.insert(
                                    0,
                                    FixedBtnModel(
                                      correctColors,
                                      correctPositions,
                                      _buttonColors,
                                    ),
                                  );
                                  resetButtonColors();
                                  setState(() {});
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 2,
                                  color:
                                      CustomColors.secondaryDefault.withOpacity(
                                    containsEmpty ? 0.2 : 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Felder prüfen',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      CustomColors.secondaryDefault.withOpacity(
                                    containsEmpty ? 0.2 : 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
