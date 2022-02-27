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
import 'game_button_widget.dart';

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
