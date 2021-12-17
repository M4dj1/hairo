import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Map userValues;
  Profile(this.userValues);
  @override
  _ProfileState createState() => _ProfileState();
}

var color1 = Color(0xff115170);
var color2 = Color(0xFF0d3d54);

class _ProfileState extends State<Profile> {
  String name = '';
  String mobile = '';
  String gend = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 8.0,
        ),
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
                    '<' + mobile + '>',
                    style: TextStyle(
                        color:
                            Colors.deepOrangeAccent.shade100.withOpacity(0.7)),
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
                        colors: [color1, color2])),
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
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrangeAccent.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sessions',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'took',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '?',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrangeAccent.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Days since last',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'last Session',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrangeAccent.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Reached',
                        style: TextStyle(
                            color: Colors.orangeAccent.withOpacity(0.7)),
                      ),
                      Text(
                        'goals',
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
          child: Column(
            children: <Widget>[
              Divider(
                height: 8.0,
              ),
              ListTile(
                title: Text(
                  "Today's activity",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0887c4),
                  ),
                ),
                subtitle: Text(
                  '31 tasks in 5 categories',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.deepOrangeAccent.shade100.withOpacity(0.7),
                  ),
                ),
                trailing: ClipOval(
                  child: Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.orangeAccent.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        color: Colors.orangeAccent,
                      )),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  height: 160.0,
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ItemCard(Icons.favorite, 'Health', '2 tasks'),
                      ItemCard(Icons.person, 'Personal', '3 tasks'),
                      ItemCard(Icons.power, 'Power', '4 tasks'),
                      ItemCard(Icons.power, 'Power', '4 tasks'),
                      ItemCard(Icons.power, 'Power', '4 tasks'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Spacer(),
      ],
    ));
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

class ItemCard extends StatelessWidget {
  final icon;
  final name;
  final tasks;
  const ItemCard(this.icon, this.name, this.tasks);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 160.0,
        width: 120.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [color1, color2])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.deepOrangeAccent.shade100,
              ),
              Spacer(),
              Text(
                name,
                style: TextStyle(
                    color: Colors.deepOrangeAccent.shade100,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                tasks,
                style: TextStyle(
                    color: Colors.deepOrangeAccent.shade100.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
