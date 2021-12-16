import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:hairo/Screens/maps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:hairo/LoginRegScreens/loginpage.dart';
import 'package:hairo/Screens/favorites.dart';
import 'package:hairo/Screens/settings.dart';
import 'package:hairo/Screens/help.dart';
import 'package:hairo/Screens/profile.dart';
import 'package:hairo/Screens/about.dart';

class Home extends StatefulWidget {
  String uid;
  Home(this.uid);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  String appBarText = "Barbers Map";
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openRatio: 0.44,
      backdropColor: Color(0xFF0d3d54),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.grey.shade200,
            iconColor: Colors.grey.shade200,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 70, left: 30),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 30),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.grey.shade200,
                        fontFamily: 'Horizon'),
                    child: AnimatedTextKit(
                      pause: Duration(seconds: 5),
                      repeatForever: true,
                      animatedTexts: [
                        WavyAnimatedText('E C H A I R',
                            speed: Duration(milliseconds: 100)),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 0;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.map),
                    title: Text('Map'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 1;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 2;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 3;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 4;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        currentPage = 5;
                        _advancedDrawerController.hideDrawer();
                      });
                    },
                    leading: Icon(Icons.emoji_objects),
                    title: Text('About'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade200,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service\n   Privacy Policy'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff051821),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.orangeAccent,
                  ),
                );
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            _getPageAppBarTxt(currentPage),
            style: TextStyle(
              color: Colors.orangeAccent,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.orangeAccent,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('uid');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            )
          ],
        ),
        body: Container(
          child: _getPage(currentPage),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Container(
          child: Maps(),
        );
      case 1:
        return Container(
          child: Profile(widget.uid),
        );
      case 2:
        return Container(
          child: Favorites(),
        );
      case 3:
        return Container(
          child: Settings(),
        );
      case 4:
        return Container(
          child: Help(),
        );
      case 5:
        return Container(
          child: About(),
        );
      default:
        return Container(
          child: Center(
            child: Text(
              '404 - Where Are you heading !',
            ),
          ),
        );
    }
  }

  _getPageAppBarTxt(int page) {
    switch (page) {
      case 0:
        return "Barbers Map";
      case 1:
        return "Profile";
      case 2:
        return "Favorites";
      case 3:
        return "Settings";
      case 4:
        return "Help";
      case 5:
        return "About";
      default:
        return "404 - Where Are you heading !";
    }
  }
}
