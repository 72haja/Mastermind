import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/main.dart';
import 'package:mastermind/models/user_model.dart';
import 'package:mastermind/net/flutterfire.dart';
import 'package:mastermind/screens/register.dart';
import 'package:mastermind/theme/colors.dart';
import 'package:provider/provider.dart';

import 'friends.dart';

class LoginStatefulWidget extends StatefulWidget {
  const LoginStatefulWidget({Key? key}) : super(key: key);

  @override
  State<LoginStatefulWidget> createState() => _LoginStatefulWidgetState();
}

class _LoginStatefulWidgetState extends State<LoginStatefulWidget> {
  bool isLoggedIn = false;

  late TextEditingController _controllerUserEMail;
  late TextEditingController _controllerPassword;
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  String _errorMessage = '';

  bool buttonIsDisabled = true;

  @override
  void initState() {
    super.initState();
    _controllerUserEMail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserEMail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  bool _setButtonIsDisabled() {
    return _controllerUserEMail.text.isEmpty ||
        _controllerPassword.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controllerUserEMail,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Die Email ist erforderlich';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _controllerPassword,
                              obscureText: !_passwordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Das Passwort ist erforderlich';
                                }
                                return null;
                              },
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
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        bool shouldNavigate = await signIn(
                                          _controllerUserEMail.text,
                                          _controllerPassword.text,
                                        );
                                        if (shouldNavigate) {
                                          Route route = MaterialPageRoute(
                                            builder: (context) => MainView(),
                                          );
                                          Navigator.push(
                                            context,
                                            route,
                                          );
                                        } else {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                "Passwort oder Email falsch"),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
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
                                      'Login',
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
                                            const RegisterStatefulWidget(),
                                      );
                                      Navigator.push(context, route);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        width: 2,
                                        color: CustomColors.secondaryDefault
                                            .withOpacity(1),
                                      ),
                                    ),
                                    child: Text(
                                      'Registrieren',
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
