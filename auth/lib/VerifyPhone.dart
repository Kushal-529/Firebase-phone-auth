import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'Profile.dart';

class VerifyPhone extends StatefulWidget {
  final String phone;
  VerifyPhone(this.phone);
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.blue.withOpacity(0.5),
  );

  @override
  void initState() {
    super.initState();
    _verifyPhoneNo();
  }

  _verifyPhoneNo() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationId, int resendToken) async {
          setState(() {
            _verificationCode = verficationId;
            print(verficationId);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
        children: [
          SizedBox(
            height: 60.0,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Verify Phone",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              "Code is sent to +91${widget.phone}",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PinPut(
                  fieldsCount: 6,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.black),
                  eachFieldWidth: 50.0,
                  eachFieldHeight: 50.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: _verificationCode, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                              (route) => false);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Successfully Signed In')));
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid OTP! Enter a Valid OTP')));
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code?",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              VerifyPhone(widget.phone)));
                },
                child: Text(
                  " Request Again",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              VerifyPhone(widget.phone);
            },
            child: Container(
              color: Colors.indigo[900].withOpacity(0.9),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Center(
                    child: Text(
                  "VERIFY AND CONTINUE",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
