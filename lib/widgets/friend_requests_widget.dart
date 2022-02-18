import 'package:flutter/material.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/theme/colors.dart';

class FriendRequests extends StatefulWidget {
  final VoidCallback onFriendsChanged;

  const FriendRequests({Key? key, required this.onFriendsChanged})
      : super(key: key);

  @override
  State<FriendRequests> createState() => FriendRequestsState();
}

class FriendRequestsState extends State<FriendRequests> {
  List<dynamic> friendshipRequests = [];

  @override
  void initState() {
    super.initState();

    getLocalRequestedFriendships();
  }

  getLocalRequestedFriendships() async {
    friendshipRequests = await getRequestedFriendships();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in friendshipRequests) ...[
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
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'remove',
                          color: CustomColors.secondaryDefault.withOpacity(1),
                          onPressed: () async {
                            await declineFriendship(item);
                            final snackBar = SnackBar(
                              content: Text(
                                  "Freundschaftsanfrage von $item abgelehnt"),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // getLocalRequestedFriendships();
                            widget.onFriendsChanged();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 20,
                        height: 44,
                        child: IconButton(
                          iconSize: 20,
                          icon: const Icon(Icons.check_circle_outline),
                          tooltip: 'add',
                          color: CustomColors.secondaryDefault.withOpacity(1),
                          onPressed: () async {
                            await acceptFriendship(item);

                            final snackBar = SnackBar(
                              content: Text(
                                  "Freundschaftsanfrage von $item angenommen"),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
