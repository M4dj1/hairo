import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  var _passwordVisible;
  var _obscureText;
  var isFound = false;

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
                  margin: EdgeInsets.only(top: 70),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  )),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey.shade200,
                    fontFamily: 'Horizon'),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: Duration(milliseconds: 0),
                  repeatForever: false,
                  animatedTexts: [
                    WavyAnimatedText('E C H A I R',
                        speed: Duration(milliseconds: 100)),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(
                      prefixIcon: Text(
                        " +213 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent.shade100,
                            fontSize: 14),
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
                  obscureText: _obscureText,
                  maxLength: 15,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.deepOrangeAccent.shade100,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.deepOrangeAccent.shade100,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
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
                  if (_controller.text.length < 9 && _controller.text != "") {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Please verify your phone number !',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                  } else if (_passwordcontroller.text == "" ||
                      _controller.text == "") {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Password or Phone number is empty !',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      duration: new Duration(seconds: 60),
                      content: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                          new Text(
                            "    Signing-In...",
                            style: TextStyle(color: Colors.orangeAccent),
                          )
                        ],
                      ),
                    ));
                    dbRef
                        .reference()
                        .orderByChild("mobile")
                        .equalTo(_controller.text)
                        .once()
                        .then((value) {
                      if (value.value == null) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Phone number is not registered!',
                          style: TextStyle(color: Colors.red.shade600),
                          textAlign: TextAlign.center,
                        )));
                        return; //find out why ?
                      } else {
                        Map data = value.value;
                        data.forEach((key, value) async {
                          if (_passwordcontroller.text == value['password'] &&
                              _controller.text == value['mobile']) {
                            isFound = true;
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('uid', key);

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(value)),
                                (route) => false);
                          }
                        });
                        if (isFound == false) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            'Incorrect username or password !',
                            style: TextStyle(color: Colors.red.shade600),
                            textAlign: TextAlign.center,
                          )));
                        }
                      }
                    });
                  }
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
    _passwordVisible = false;
    _obscureText = true;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
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
      }
    });
  }
}
