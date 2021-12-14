import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IsNotConnected extends StatefulWidget {
  const IsNotConnected({Key? key}) : super(key: key);

  @override
  _IsNotConnectedState createState() => _IsNotConnectedState();
}

class _IsNotConnectedState extends State<IsNotConnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  fit: BoxFit.fill,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.grey.shade200,
                  fontFamily: 'Horizon'),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 0),
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText('E C H A I R',
                      speed: Duration(milliseconds: 1000)),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20.0,
                  fontFamily: 'Agne',
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Please check your internet connection and try again',
                      textAlign: TextAlign.center,
                    ),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
