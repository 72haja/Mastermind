import 'package:flutter/material.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/theme/colors.dart';

class FriendsWidget extends StatefulWidget {
  final VoidCallback onFriendsChanged;

  const FriendsWidget({Key? key, required this.onFriendsChanged})
      : super(key: key);

  @override
  State<FriendsWidget> createState() => FriendsWidgetState();
}

class FriendsWidgetState extends State<FriendsWidget> {
  List<dynamic> friends = [];

  @override
  void initState() {
    super.initState();

    getLocalFriends();
  }

  getLocalFriends() async {
    friends = await getFriends();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in friends) ...[
          Container(
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
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.secondaryDefault.withOpacity(1),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 44,
                        child: IconButton(
                          iconSize: 20,
                          icon: const Icon(Icons.delete_outline_rounded),
                          tooltip: 'add',
                          color: CustomColors.secondaryDefault.withOpacity(1),
                          onPressed: () async {
                            await removeFriend(item);

                            getLocalFriends();
                            widget.onFriendsChanged();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ]
      ],
    );
  }
}
