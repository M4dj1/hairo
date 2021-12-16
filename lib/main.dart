import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hairo/LoginRegScreens/loginpage.dart';
import 'package:hairo/isNotConnected.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home.dart';
import 'dart:io';

Future<void> main() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      if (uid != null) {
        dbRef.child(uid).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> userValues = snapshot.value;
          runApp(MaterialApp(
            home: Home(userValues),
            theme: ThemeData(scaffoldBackgroundColor: Color(0xff051821)),
          ));
        });
      } else {
        runApp(MaterialApp(
          home: LoginScreen(),
          theme: ThemeData(scaffoldBackgroundColor: Color(0xff051821)),
        ));
      }
    }
  } on SocketException catch (_) {
    runApp(MaterialApp(
      home: IsNotConnected(),
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff051821)),
    ));
  }
}

DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("users");
