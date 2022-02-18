import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mastermind/screens/login.dart';

import 'package:mastermind/theme/app_theme.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'widgets/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.defaultTheme,
        home: Navigator(
          pages: const [
            MaterialPage(
              child: LoginStatefulWidget(),
            ),
          ],
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        ));
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  initState() {
    setState(() {});
  }

  final _buttons = [
    MainViewButton(
      icon: Icons.play_arrow_outlined,
      name: 'Neues spiel',
      route: 'Game',
    ),
    MainViewButton(
      icon: Icons.military_tech,
      name: 'Bestenlisten',
      route: 'Bestenliste',
    ),
    MainViewButton(
      icon: Icons.people_outlined,
      name: 'Freunde',
      route: 'Friends',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var loggedInEmail = FirebaseAuth.instance().currentUser?.email.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastermind'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Text(
                    'Hallo',
                    style: TextStyle(
                        fontSize: 20,
                        color: CustomColors.primaryDark.withOpacity(1)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    loggedInEmail!,
                    style: TextStyle(
                        fontSize: 25,
                        color: CustomColors.primaryDark.withOpacity(1)),
                  ),
                ],
              ),
            ),
            for (var item in _buttons) ...[
              item,
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
