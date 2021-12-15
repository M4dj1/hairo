import 'package:hairo/main.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../intro.dart';

class PasswordScreen extends StatefulWidget {
  final String phone;
  final String uid;
  PasswordScreen(this.phone, this.uid);
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<PasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerC = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  var _passwordVisible;
  var _passwordVisible1;
  var _obscureText;
  var _obscureText1;
  @override
  Widget build(BuildContext context) {
    _phoneController.text = (widget.phone);
    var gendController = "";
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.orangeAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ToggleSwitch(
                borderWidth: 1,
                iconSize: 20,
                animationDuration: 400,
                animate: true,
                minWidth: 100.0,
                initialLabelIndex: null,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Color(0xff051821),
                inactiveFgColor: Colors.deepOrangeAccent.shade100,
                borderColor: [Color(0xff0d3d54)],
                totalSwitches: 2,
                labels: ['Male', 'Female'],
                icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                activeBgColors: [
                  [Colors.blue.shade300],
                  [Colors.pink.shade300]
                ],
                onToggle: (index) {
                  index == 0
                      ? gendController = "Male"
                      : gendController = "Female";
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 30.0, left: 30.0, top: 40.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _nameController,
                maxLength: 15,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.face_outlined,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrangeAccent.shade100),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 30.0, left: 30.0, top: 30.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _passwordController,
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
                            ? Icons.visibility
                            : Icons.visibility_off,
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
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0, left: 30.0, top: 30.0, bottom: 40),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _passwordControllerC,
                obscureText: _obscureText1,
                maxLength: 15,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible1
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.deepOrangeAccent.shade100,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrangeAccent.shade100),
                    )),
              ),
            ),
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
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                    duration: new Duration(seconds: 4),
                    content: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CircularProgressIndicator(
                          color: Colors.orangeAccent,
                        ),
                        new Text(
                          "    Signing-Up...",
                          style: TextStyle(color: Colors.orangeAccent),
                        )
                      ],
                    ),
                  ));
                  if (gendController == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Please select your gender',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                  } else if (_nameController.text.length < 6) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Name should be minimum 6 characters',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_passwordController.text.length < 6) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Password should be minimum 6 characters',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                  } else if (_passwordControllerC.text !=
                      _passwordController.text) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Passwords Dont match',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                    _passwordControllerC.text = "";
                    _passwordController.text = "";
                  } else {
                    Map userDetails = {
                      "uid": widget.uid,
                      "mobile": widget.phone,
                      "password": _passwordController.text,
                      "name": _nameController.text,
                      "gender": gendController,
                    };
                    dbRef
                        .child(widget.phone)
                        .set(userDetails)
                        .then((value) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('mobile', widget.phone);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Intro(userDetails)),
                          (route) => false);
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${error.toString()}')));
                    });
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible1 = false;
    _obscureText = true;
    _obscureText1 = true;
    // TODO: implement initState
    super.initState();
  }
}
