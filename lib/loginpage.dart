import 'package:hairo/main.dart';
import 'package:flutter/material.dart';

import 'home.dart';
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
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text(
                    'Login Into Application',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _passwordcontroller,
                  obscureText: true,
                  maxLength: 15,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
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
                    data.forEach((key, value) {
                      if (_passwordcontroller.text == value['password'] &&
                          (_controller.text == value['mobile'])) {
                        print("User Exist");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(key, value['name'])),
                            (route) => false);
                      } else {
                        print("User Not found Exist");
                      }
                    });
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Registartion()));
                },
                child: Text(
                  'Don\'t have account? Signup',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
