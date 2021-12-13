import 'package:hairo/LoginRegScreens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_map/flutter_map.dart';

class Home extends StatefulWidget {
  Map userValues;
  Home(this.userValues);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _advancedDrawerController = AdvancedDrawerController();
  MapController mapController = new MapController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        openRatio: 0.42,
        backdropColor: Color(0xFF1A4645),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: true,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
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
                          WavyAnimatedText('H a i r O',
                              speed: Duration(milliseconds: 100)),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 30,
                    onTap: () {},
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  ListTile(
                    horizontalTitleGap: 30,
                    onTap: () {},
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    minLeadingWidth: 10,
                    horizontalTitleGap: 30,
                    onTap: () {},
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                  ),
                  ListTile(
                    minLeadingWidth: 33,
                    horizontalTitleGap: 30,
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    minLeadingWidth: 46,
                    horizontalTitleGap: 30,
                    onTap: () {},
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                  ListTile(
                    horizontalTitleGap: 31,
                    onTap: () {},
                    leading: Icon(Icons.emoji_objects),
                    title: Text('About'),
                  ),
                  Spacer(),
                  DefaultTextStyle(
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
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
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
                      ),
                    );
                  },
                ),
              ),
              title: Text('Barbers Map'),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('mobile');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                )
              ],
            ),
            body: Scaffold(
              body: Center(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    minZoom: 8.5,
                    maxZoom: 17.0,
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                  layers: <LayerOptions>[
                    TileLayerOptions(
                        urlTemplate:
                            "https://api.mapbox.com/styles/v1/madji/ckrn1yjx82bos19o1y805hvbf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g",
                        additionalOptions: {
                          'accessToken':
                              'pk.eyJ1IjoibWFkamkiLCJhIjoiY2tybWc4NWYwMHZvejJwbDdibjd2NXBqZCJ9.uJ_fye7QXBKBjBznsmIe1g',
                          'id': 'mapbox.mapbox-streets-v8'
                        }),
                  ],
                ),
              ),
            )));
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
}
