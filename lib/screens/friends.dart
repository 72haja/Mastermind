import 'package:flutter/material.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:mastermind/widgets/friend_requests_widget.dart';
import 'package:mastermind/widgets/friends_widget.dart';

class FriendsStatefulWidget extends StatefulWidget {
  const FriendsStatefulWidget({Key? key}) : super(key: key);

  @override
  State<FriendsStatefulWidget> createState() => _FriendsStatefulWidgetState();
}

class _FriendsStatefulWidgetState extends State<FriendsStatefulWidget> {
  late TextEditingController _controllerUserName;
  late TextEditingController _controllerPassword;

  final GlobalKey<FriendsWidgetState> _keyFriendsWidgetState = GlobalKey();
  final GlobalKey<FriendRequestsState> _keyFriendRequestsState = GlobalKey();

  final ButtonStyle style = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      CustomColors.secondaryDefault.withOpacity(1),
    ),
  );

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  callback(index) {
    print("Callback fired");
    _keyFriendsWidgetState.currentState?.getLocalFriends();
    _keyFriendRequestsState.currentState?.getLocalRequestedFriendships();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freunde'),
      ),
      body: Container(
        color: CustomColors.backgroundLight.withOpacity(1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FriendsWidget(
                  key: _keyFriendsWidgetState,
                  onFriendsChanged: () {
                    print("Changed");
                    _keyFriendsWidgetState.currentState?.getLocalFriends();
                    _keyFriendRequestsState.currentState
                        ?.getLocalRequestedFriendships();
                  },
                ),
                FriendRequests(
                  key: _keyFriendRequestsState,
                  onFriendsChanged: () {
                    print("Changed");
                    _keyFriendsWidgetState.currentState?.getLocalFriends();
                    _keyFriendRequestsState.currentState
                        ?.getLocalRequestedFriendships();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              late TextEditingController _controllerUserName =
                  TextEditingController();

              return SimpleDialog(
                title: Text(
                  'Freund hinzufügen',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.secondaryDefault.withOpacity(1),
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerUserName,
                          decoration: const InputDecoration(
                            labelText: 'Nutzername',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Der Nutzername ist erforderlich';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  var userFound = await requestFriendship(
                                    _controllerUserName.text,
                                  );

                                  var text = userFound
                                      ? "Anfrage wurde an den Nutzer gesendet"
                                      : "Nutzer nicht gefunden";

                                  final snackBar = SnackBar(
                                    content: Text(text),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  Navigator.pop(context, true);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    CustomColors.secondaryDefault
                                        .withOpacity(1),
                                  ),
                                ),
                                child: Text(
                                  'Anfragen',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CustomColors.primaryWhite
                                        .withOpacity(1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    width: 2,
                                    color: CustomColors.secondaryDefault
                                        .withOpacity(1),
                                  ),
                                ),
                                child: Text(
                                  'Abbrechen',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CustomColors.secondaryDefault
                                        .withOpacity(1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        },
        backgroundColor: CustomColors.secondaryLight.withOpacity(1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
