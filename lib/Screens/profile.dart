import 'package:flutter/material.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class Profile extends StatefulWidget {
  Map userValues;
  Profile(this.userValues);
  @override
  _ProfileState createState() => _ProfileState();
}

var color1 = Color(0xff115170);
var color2 = Color(0xFF0d3d54);

class _ProfileState extends State<Profile> {
  int _intUsedEchairs = 0;
  int _intDays = 0;
  String name = '';
  String mobile = '';
  String gend = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    mobile,
                    style: TextStyle(
                      color: Colors.deepOrangeAccent.shade100.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32),
              child: Container(
                height: 4.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffd5e8fe), Color(0xffedf5ff)])),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      NumberSlideAnimation(
                        number: _intUsedEchairs.toString(),
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        textStyle: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xffff8215),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Used',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'Echairs',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      NumberSlideAnimation(
                        number: _intDays.toString(),
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        textStyle: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xffff8215),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Days since',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'last Echair',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Scorpions',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xffff8215),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Last',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'Esalon',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 32.0,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xffd5e8fe), Color(0xffedf5ff)]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 8.0,
                  ),
                  ListTile(
                    title: Text(
                      "Account Info",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff0887c4),
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: ClipOval(
                      child: Container(
                          height: 40.0,
                          width: 40.0,
                          color: Color(0xff115170).withOpacity(0.2),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Color(0xff115170),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ItemCard(Icons.face, 'Name', name),
                            ItemCard(Icons.lock_outline, 'Password', '******'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ItemCard(Icons.male, 'Gender', gend),
                            ItemCard(Icons.mobile_friendly_outlined, 'Number',
                                mobile),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    )),
                  )
                ],
              ),
            )),
        Spacer(),
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    _intUsedEchairs = 13;
    _intDays = 61;
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

class ItemCard extends StatelessWidget {
  final icon;
  final name;
  final tasks;
  const ItemCard(this.icon, this.name, this.tasks);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 120.0,
        width: 160.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffffbc66), Color(0xffff8215)]),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                tasks,
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
