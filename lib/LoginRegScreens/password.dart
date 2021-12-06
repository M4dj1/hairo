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
      appBar: AppBar(
        title: Text('Set Password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'mobile',
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _nameController,
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
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
