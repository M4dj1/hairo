import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hairo/main.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile(this.uid);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String mobile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfff58800), Color(0xfff8bc24)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.orange.shade400,
            child: ListTile(
              title: Text(
                '43 Days',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepOrangeAccent.shade200,
                ),
              ),
              subtitle: Text(
                'Since Last Session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.orange.shade300,
            child: ListTile(
              title: Text(
                mobile,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepOrangeAccent.shade200,
                ),
              ),
              subtitle: Text(
                'My Phone Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.orange.shade200,
            child: ListTile(
              title: Text(
                '***********',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepOrangeAccent.shade200,
                ),
              ),
              subtitle: Text(
                'My Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    dbRef.child(widget.uid).once().then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value['name'];
        name = name.substring(0, 1).toUpperCase() + name.substring(1);
        mobile = snapshot.value['mobile'];
        if (mobile.substring(0, 1) != '0') {
          mobile = '0' + mobile;
        }
      });
    });
  }
}
