import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairo/LoginRegScreens/password.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  CountDownController _controller = CountDownController();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120),
              child: Center(
                child: Text(
                  'Verify +213-${widget.phone}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: PinCodeTextField(
                textStyle: TextStyle(color: Color(0xff115170)),
                appContext: context,
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                  selectedColor: Colors.red,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                onCompleted: (v) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: v))
                        .then((value) async {
                      if (value.user != null) {
                        setPassword(value.user!.uid);
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('invalid OTP')));
                  }
                },
                onChanged: (value) {
                  print(value);
                  setState(() {});
                },
              ),
            ),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/smartphone.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    )),
                CircularCountDownTimer(
                  duration: 120,
                  initialDuration: 0,
                  controller: _controller,
                  width: 28,
                  height: 28,
                  ringColor: Colors.blue.shade200,
                  ringGradient: null,
                  fillColor: Color(0xff266867),
                  fillGradient: null,
                  backgroundColor: Colors.red.shade400,
                  backgroundGradient: null,
                  strokeWidth: 2.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    print('Countdown Started');
                  },
                  onComplete: () {
                    print('Countdown Ended');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+213${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              setPassword(value.user!.uid);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  setPassword(uid) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordScreen(widget.phone, uid)),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
