import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hairo/main.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    'Login Into Hairo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(
                      prefixIcon: Text(
                        "+213 ",
                        style: TextStyle(
                            color: Colors.deepOrangeAccent.shade100,
                            fontSize: 16),
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.white38),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrangeAccent.shade100),
                      )),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 40),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  keyboardType: TextInputType.text,
                  controller: _passwordcontroller,
                  obscureText: true,
                  maxLength: 15,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white38),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrangeAccent.shade100),
                      )),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.only(top: 10.0, right: 100.0, left: 100.0),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  dbRef
                      .reference()
                      .orderByChild("mobile")
                      .equalTo(_controller.text)
                      .get()
                      .then((value) {
                    if (value.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No User Found')));
                      return;
                    }

                    print("User Password ${value.value}");
                    Map data = value.value;
                    var isFound = false;
                    data.forEach((key, value) {
                      if (_passwordcontroller.text == value['password'] &&
                          (_controller.text == value['mobile'])) {
                        isFound = true;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(key, value['name'])),
                            (route) => false);
                      }
                    });
                    if (isFound == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Incorrect username or password !',
                        style: TextStyle(color: Colors.red.shade600),
                        textAlign: TextAlign.center,
                      )));
                    }
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registartion()),
                  );
                },
                child: Text(
                  'Don\'t have an account ? - Signup',
                  style: TextStyle(color: Colors.deepOrangeAccent.shade100),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    final currentUser = FirebaseAuth.instance.currentUser;
    var name;
    print("inside init loginpage");
    if (currentUser != null) {
      print("currentuser exists");
      dbRef
          .child(currentUser.uid)
          .child("name")
          .once()
          .then((DataSnapshot data) {
        name = data.value;
        print(currentUser.uid.toString());
        print(name.toString());
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Home(currentUser.uid.toString(), name.toString())));
    }
    super.initState();
  }
}
