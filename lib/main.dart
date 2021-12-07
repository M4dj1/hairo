import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'LoginRegScreens/loginpage.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0x7D7D7D7D)),
      home: IsSignedIn(),
    );
  }
}

class IsSignedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    var name;

    if (currentUser != null) {
      dbRef
          .child(currentUser.uid)
          .child("name")
          .once()
          .then((DataSnapshot data) {
        name = data.value;
        print(currentUser.uid.toString());
        print(name.toString());
      });
      return Home(currentUser.uid, name.toString());
    } else {
      return LoginScreen();
    }
  }
}
