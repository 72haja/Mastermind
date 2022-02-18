import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:provider/single_child_widget.dart';

class LeaderboardWidget extends StatefulWidget {
  const LeaderboardWidget({Key? key}) : super(key: key);

  @override
  _LeaderboardWidgetState createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget> {
  late List<_UserRow> userRows = [];
  late List<_UserRow> globalRows = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillRows();
  }

  void fillRows() async {
    var userTimes = await getUserLeaderboard();
    var globalTimes = await getFriendsLeaderboard();

    userTimes.forEach((time) {
      userRows.add(_UserRow(
        time.toString(),
        '',
      ));
    });

    globalTimes.forEach((row) {
      globalRows.add(_UserRow(
        row.time.toString(),
        row.username,
      ));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bestenliste'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
            child: Text(
              "Deine Bestenliste".toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: CustomColors.primaryDark.withOpacity(1),
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          for (var item in userRows) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.gcWhite.withOpacity(1),
                  border: Border.all(
                    width: 2.0,
                    color: CustomColors.secondaryLight.withOpacity(1),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
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
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text((userRows.indexOf(item) + 1).toString() + "."),
                      Text(item.time),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
            child: Text(
              "Freundes Bestenliste".toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: CustomColors.primaryDark.withOpacity(1),
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          for (var item in globalRows) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.gcWhite.withOpacity(1),
                  border: Border.all(
                    width: 2.0,
                    color: CustomColors.secondaryLight.withOpacity(1),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
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
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text((globalRows.indexOf(item) + 1).toString() + "."),
                      Text(item.username),
                      Text(item.time),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ]
        ],
      ),
    );
  }
}

class _UserRow {
  _UserRow(
    this.time,
    this.username,
  );

  final String time;
  final String username;
}
