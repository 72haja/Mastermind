import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/models/user_model.dart';

import '../models/leaderboard_user_model.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance()
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    // _errorMessageName = e.toString();
    print(e.toString());
    return false;
  }
}

Future<bool> register(String email, String username, String password) async {
  try {
    if (await checkUserName(username)) {
      throw ErrorDescription("Username ist schon vergeben");
    }

    await FirebaseAuth.instance()
        .createUserWithEmailAndPassword(email: email, password: password);

    addUser(email, username);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('Das angegebene Passwort ist zu schwach');
    } else if (e.code == 'email-already-in-use') {
      print('Die E-Mail wird bereits verwendet');
    }
    return false;
  } catch (e) {
    // _errorMessageName = e.toString();
    print(e.toString());
    if (e.toString() == "Username ist schon vergeben") {
      throw ErrorDescription("Username ist schon vergeben");
    }
    return false;
  }
}

Future<bool> saveGameStats(int time) async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;
    CollectionReference leaderboards =
        FirebaseFirestore.instance.collection('leaderboard');

    var user = null;

    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["email"].toString().toLowerCase() ==
            currentUser?.email?.toLowerCase()) {
          user = doc.reference;
        }
      }
    });

    if (user == null) {
      print("no User found");
      return false;
    } else {
      print("save game to User: $user");
    }

    leaderboards
        .add({'time': time, 'user': user})
        .then((value) => print("Game Stats Added"))
        .catchError((error) => print("Failed to add Game Stats: $error"));
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addUser(String email, String username) async {
  try {
    CollectionReference documentReference =
        FirebaseFirestore.instance.collection('user');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      documentReference.add({
        'email': email,
        'username': username,
      });
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> checkUserName(String username) async {
  try {
    CollectionReference documentReference =
        FirebaseFirestore.instance.collection('user');

    var userExists = await FirebaseFirestore.instance
        .collection('user')
        .where("username", isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.isNotEmpty;
    });

    return userExists;
  } catch (e) {
    return false;
  }
}

Future<List> getFriendsLeaderboard() async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;
    var scores = [];
    var tmp = [];

    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["email"].toString().toLowerCase() ==
            currentUser?.email?.toLowerCase()) {
          user = doc.data() as Map<String, dynamic>;
        }
      }
    });

    await FirebaseFirestore.instance
        .collection('leaderboard')
        // .where('user', isEqualTo: user)
        .orderBy('time', descending: false)
        .limit(6)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        tmp.add([doc["user"], doc["time"]]);
      }
    });

    for (var arr in tmp) {
      await arr[0].get().then((DocumentSnapshot documentSnapshot) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        var username = data["username"];
        if (user["friends"].contains(username) ||
            username == user["username"]) {
          var time = computeTime(arr[1]);
          scores.add(LeaderboardUserModel(time: time, username: username));
        }
      });
    }

    return scores;
  } catch (e) {
    return [];
  }
}

Future<List> getUserLeaderboard() async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;
    var scores = [];

    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["email"].toString().toLowerCase() ==
            currentUser?.email?.toLowerCase()) {
          user = doc.reference;
        }
      }
    });

    await FirebaseFirestore.instance
        .collection('leaderboard')
        // .where('user', isEqualTo: user)
        .orderBy('time', descending: false)
        .limit(6)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["user"] == user) {
          scores.add(doc["time"]);
        }
      }
    });

    var asList = scores.toList();

    String computeTime(int time) {
      Duration duration = Duration(seconds: time);

      String twoDigits(int n) => n.toString().padLeft(2, '0');

      var hours = twoDigits(duration.inHours.remainder(60));
      var minutes = twoDigits(duration.inMinutes.remainder(60));
      var seconds = twoDigits(duration.inSeconds.remainder(60));

      return '$hours:$minutes:$seconds';
    }

    var mappedList = asList.map((e) => computeTime(e)).toList();

    return mappedList;
  } catch (e) {
    return [];
  }
}

String computeTime(int time) {
  Duration duration = Duration(seconds: time);

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  var hours = twoDigits(duration.inHours.remainder(60));
  var minutes = twoDigits(duration.inMinutes.remainder(60));
  var seconds = twoDigits(duration.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

Future<Map<String, dynamic>> getCurrentUserData() async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var currentUserData = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get()
        .then((value) => value.docs.first.data());

    return currentUserData;
  } catch (e) {
    throw Error();
  }
}

Future<List> getFriends() async {
  try {
    var currentUserData = await getCurrentUserData();

    if (currentUserData.containsKey("friends")) {
      return currentUserData["friends"];
    }
    return [];
  } catch (e) {
    throw Error();
  }
}

Future<List> getRequestedFriendships() async {
  try {
    var currentUserData = await getCurrentUserData();

    if (currentUserData.containsKey("requestedFriendships")) {
      return currentUserData["requestedFriendships"];
    }
    return [];
  } catch (e) {
    throw Error();
  }
}

Future<bool> requestFriendship(username) async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;

    await FirebaseFirestore.instance
        .collection('user')
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        user = querySnapshot.docs.first;
      } else {
        throw ErrorDescription("User nicht gefunden");
      }
    });

    var currentUserDoc = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get()
        .then((value) => value.docs.first);

    DocumentReference documentReferenceCurrentUser =
        FirebaseFirestore.instance.collection('user').doc(currentUserDoc.id);
    DocumentReference documentReferenceFriend =
        FirebaseFirestore.instance.collection('user').doc(user.id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          documentReferenceCurrentUser.update({
            "friendsOnHold": FieldValue.arrayUnion([username])
          });
          documentReferenceFriend.update({
            "requestedFriendships":
                FieldValue.arrayUnion([currentUserDoc.data()['username']])
          });
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> acceptFriendship(username) async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;

    await FirebaseFirestore.instance
        .collection('user')
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        user = querySnapshot.docs.first;
      } else {
        throw ErrorDescription("User nicht gefunden");
      }
    });

    var currentUserDoc = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get()
        .then((value) => value.docs.first);

    DocumentReference documentReferenceCurrentUser =
        FirebaseFirestore.instance.collection('user').doc(currentUserDoc.id);
    DocumentReference documentReferenceFriend =
        FirebaseFirestore.instance.collection('user').doc(user.id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          documentReferenceCurrentUser.update({
            "requestedFriendships": FieldValue.arrayRemove([username]),
            "friends": FieldValue.arrayUnion([username])
          });
          documentReferenceFriend.update({
            "friendsOnHold":
                FieldValue.arrayRemove([currentUserDoc.data()['username']]),
            "friends":
                FieldValue.arrayUnion([currentUserDoc.data()['username']])
          });
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> declineFriendship(username) async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;

    await FirebaseFirestore.instance
        .collection('user')
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        user = querySnapshot.docs.first;
      } else {
        throw ErrorDescription("User nicht gefunden");
      }
    });

    var currentUserDoc = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get()
        .then((value) => value.docs.first);

    DocumentReference documentReferenceCurrentUser =
        FirebaseFirestore.instance.collection('user').doc(currentUserDoc.id);
    DocumentReference documentReferenceFriend =
        FirebaseFirestore.instance.collection('user').doc(user.id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          documentReferenceCurrentUser.update({
            "requestedFriendships": FieldValue.arrayRemove([username]),
          });
          documentReferenceFriend.update({
            "friendsOnHold":
                FieldValue.arrayRemove([currentUserDoc.data()['username']]),
          });
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> removeFriend(username) async {
  try {
    User? currentUser = FirebaseAuth.instance().currentUser;

    var user;

    await FirebaseFirestore.instance
        .collection('user')
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        user = querySnapshot.docs.first;
      } else {
        throw ErrorDescription("User nicht gefunden");
      }
    });

    var currentUserDoc = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get()
        .then((value) => value.docs.first);

    DocumentReference documentReferenceCurrentUser =
        FirebaseFirestore.instance.collection('user').doc(currentUserDoc.id);
    DocumentReference documentReferenceFriend =
        FirebaseFirestore.instance.collection('user').doc(user.id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          documentReferenceCurrentUser.update({
            "friends": FieldValue.arrayRemove([username]),
          });
          documentReferenceFriend.update({
            "friends":
                FieldValue.arrayRemove([currentUserDoc.data()['username']]),
          });
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  } catch (e) {
    print(e);
    return false;
  }
}
