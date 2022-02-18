import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/models/user_model.dart';
import 'package:mastermind/screens/friends.dart';
import 'package:mastermind/screens/game.dart';
import 'package:mastermind/screens/leaderboard.dart';
import 'package:mastermind/screens/login.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'color_chose_button_widget.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class HiddenBoxWidget extends StatelessWidget {
  final List<GameButtonWidget> childs;

  const HiddenBoxWidget({Key? key, required this.childs}) : super(key: key);

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
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in childs) ...[
              item,
              if (childs.indexOf(item) != 4) const Spacer(),
            ],
          ],
        ),
      ),
    );
  }
}

class GameButtonWidget extends StatefulWidget {
  final Color color;
  bool hidden;

  final VoidCallback onButtonClicked;

  GameButtonWidget({
    Key? key,
    this.color = CustomColors.gcEmpty,
    required this.hidden,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onButtonClicked(),
      child: Container(
        width: 40.0,
        height: 40.0,
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

class MainViewButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final String route;

  final ButtonStyle style = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      CustomColors.secondaryDefault.withOpacity(1),
    ),
  );

  MainViewButton({
    required this.name,
    required this.icon,
    required this.route,
    Key? key,
  }) : super(key: key);

  bool userIsLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 24.0,
        ),
        onPressed: () {
          if (route == "Friends") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FriendsStatefulWidget(),
              ),
            );
          }
          if (route == "Bestenliste") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LeaderboardWidget(),
              ),
            );
          }
          if (route == "Game") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameStatefulWidget(),
              ),
            );
          }
        },
        style: style,
        label: SizedBox(
          width: double.infinity,
          child: Text(
            name.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CustomColors.primaryWhite.withOpacity(1),
            ),
          ),
        ),
      ),
    );
  }
}
