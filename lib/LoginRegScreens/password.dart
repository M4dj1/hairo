import 'package:hairo/main.dart';
import 'package:flutter/material.dart';

import '../home.dart';

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
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _phoneController.text = (widget.phone);
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  'User Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 40.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'mobile',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                  ),
                )),
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
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(color: Colors.white38),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0, left: 30.0, top: 30.0, bottom: 40),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white38),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                ),
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
                  if (_nameController.text.length <= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Password should be minimum 4 characters')));
                    return;
                  }
                  if (_passwordController.text.length <= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Password should be minimum 4 characters')));
                  }
                  Map userDetails = {
                    "mobile": widget.phone,
                    "password": _passwordController.text,
                    "name": _nameController.text,
                  };

                  dbRef.child(widget.uid).set(userDetails).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home(widget.uid, _nameController.text)),
                        (route) => false);
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${error.toString()}')));
                  });
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
    // TODO: implement initState
    super.initState();
  }
}
