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
                    'Signup with Mobile Number',
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
                  style: TextStyle(color: Colors.white60),
                  cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+213'),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: MaterialButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(_controller.text)));
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
