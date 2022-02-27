import 'package:flutter/material.dart';
import 'package:mastermind/models/fixed_btn_model.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/answer_indicator_widget.dart';

import 'game_button_widget.dart';

class FixedColorWidgetState extends StatelessWidget {
  final List<FixedBtnModel> fixedBtns;

  const FixedColorWidgetState({
    Key? key,
    required this.fixedBtns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          for (var row in fixedBtns) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          width: 20,
                          height: 40,
                          top: 0,
                          left: -10,
                          child: Column(
                            children: [
                              const Spacer(),
                              for (var i = 0;
                                  i < row.correctColors.length;
                                  i++) ...[
                                AnswerIndicatorWidget(
                                  color: row.correctColors[i]
                                      ? CustomColors.secondaryLight
                                      : CustomColors.gcWhite,
                                ),
                                if (i != 4)
                                  const SizedBox(
                                    height: 1,
                                  ),
                              ],
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var i = 0; i < row.fixedBtns.length; i++) ...[
                    GameButtonWidget(
                      hidden: false,
                      onButtonClicked: () {},
                      color: row.fixedBtns[i],
                    ),
                    if (i != 4) const Spacer(),
                  ],
                  SizedBox(
                    width: 20,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          width: 20,
                          height: 40,
                          top: 0,
                          right: -10,
                          child: Column(
                            children: [
                              const Spacer(),
                              for (var i = 0;
                                  i < row.correctPositions.length;
                                  i++) ...[
                                AnswerIndicatorWidget(
                                  color: row.correctPositions[i]
                                      ? CustomColors.secondaryLight
                                      : CustomColors.gcWhite,
                                ),
                                if (i != 4)
                                  const SizedBox(
                                    height: 1,
                                  ),
                              ],
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
