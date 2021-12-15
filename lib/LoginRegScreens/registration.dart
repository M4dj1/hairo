import 'package:flutter/material.dart';

import 'otp.dart';

class Registartion extends StatefulWidget {
  @override
  _RegistartionState createState() => _RegistartionState();
}

class _RegistartionState extends State<Registartion> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    'Enter your Phone number',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.orangeAccent),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 40),
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
              )
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
                  } else if (_controller.text == "") {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Phone number is empty !',
                      style: TextStyle(color: Colors.red.shade600),
                      textAlign: TextAlign.center,
                    )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(_controller.text)));
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
