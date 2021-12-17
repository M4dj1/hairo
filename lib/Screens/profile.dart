import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Map userValues;
  Profile(this.userValues);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String mobile = '';
  String gend = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    color: Color(0xff115170),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange.shade600,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.vpn_lock,
                      color: Color(0xff115170),
                    ),
                    ListTile(
                      title: Text(
                        mobile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF0d3d54),
                        ),
                      ),
                      subtitle: Text(
                        '(Only Salons can see your number)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange.shade500,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.vpn_lock,
                      color: Color(0xff115170),
                    ),
                    ListTile(
                      title: Text(
                        '43 Days',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF0d3d54),
                        ),
                      ),
                      subtitle: Text(
                        'Since My Last "Haircut"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange.shade400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.public,
                      color: Color(0xff115170),
                    ),
                    ListTile(
                      title: Text(
                        gend,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF0d3d54),
                        ),
                      ),
                      subtitle: Text(
                        'Gender',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange.shade300,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.public,
                      color: Color(0xff115170),
                    ),
                    ListTile(
                      title: Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF0d3d54),
                        ),
                      ),
                      subtitle: Text(
                        'Visited Salons',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    gend = widget.userValues['gender'];
    name = widget.userValues['name'].toString().substring(0, 1).toUpperCase() +
        widget.userValues['name'].toString().substring(1);
    if (widget.userValues['mobile'].toString().substring(0, 1) != '0') {
      mobile = '0' + widget.userValues['mobile'].toString();
    } else {
      mobile = widget.userValues['mobile'].toString();
    }
  }
}
