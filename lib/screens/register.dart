import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/main.dart';
import 'package:mastermind/models/user_model.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/screens/login.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:provider/provider.dart';

import 'friends.dart';

class RegisterStatefulWidget extends StatefulWidget {
  const RegisterStatefulWidget({Key? key}) : super(key: key);

  @override
  State<RegisterStatefulWidget> createState() => _RegisterStatefulWidgetState();
}

class _RegisterStatefulWidgetState extends State<RegisterStatefulWidget> {
  late TextEditingController _controllerUserEmail;
  late TextEditingController _controllerUserName;
  late TextEditingController _controllerPassword;
  bool _passwordVisible = false;
  String _errorMessageName = '';
  String _errorMessagePassword = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerUserEmail = TextEditingController();
    _controllerUserName = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrieren'),
      ),
      body: Container(
        color: CustomColors.backgroundLight.withOpacity(1),
        child: Center(
          child: MergeSemantics(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Um sich mit Freunden in der Bestenliste messern zu können, müssen sie einen Account anlegen oder sich einloggen! ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        color: CustomColors.secondaryDefault.withOpacity(1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Form(
                      child: Padding(
                        key: _formKey,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Registrieren',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controllerUserEmail,
                              decoration: const InputDecoration(
                                labelText: 'E-Mail',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Die Email ist erforderlich';
                                }
                                return null;
                              },
                            ),
                            if (_errorMessagePassword.isNotEmpty)
                              Text(_errorMessageName),
                            const SizedBox(height: 20),
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
                            if (_errorMessagePassword.isNotEmpty)
                              Text(_errorMessageName),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controllerPassword,
                              obscureText: !_passwordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                labelText: 'Passwort',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _passwordVisible = !_passwordVisible;
                                      },
                                    );
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Das Passwort ist erforderlich';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await register(
                                          _controllerUserEmail.text,
                                          _controllerUserName.text,
                                          _controllerPassword.text,
                                        );

                                        Route route = MaterialPageRoute(
                                            builder: (context) =>
                                                const MainView());
                                        Navigator.push(context, route);
                                      } catch (e) {

                                        final snackBar = SnackBar(
                                          content: Text(e.toString()),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        CustomColors.secondaryDefault
                                            .withOpacity(1),
                                      ),
                                    ),
                                    child: Text(
                                      'Registrieren',
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
                                      Route route = MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginStatefulWidget(),
                                      );
                                      Navigator.pushReplacement(context, route);
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
                    ),
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
