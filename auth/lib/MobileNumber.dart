import 'package:Liveasy/Language.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'VerifyPhone.dart';

class MobileNumber extends StatefulWidget {
  @override
  _MobileNumberState createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  TextEditingController _controller = TextEditingController();
  //final formKey = GlobalKey<FormState>();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SelectLanguage()),
                  (route) => false);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white38,
          elevation: 0,
        ),
        body: Form(
          //key: formKey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Please enter your mobile number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Text(
                      "You'll receive a 4 digit code",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    Text(
                      "to verify next.",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.always,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          hintText: "Mobile Number",
                          initialValue: number,
                          maxLength: 10,
                          textFieldController: _controller,
                          formatInput: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    child: FlatButton(
                  onPressed: () {
                    if (_controller.text.length < 10) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Enter a Valid Phone Number')));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VerifyPhone(_controller.text)));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    color: Colors.indigo[900].withOpacity(0.9),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.0),
                      child: Center(
                          child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )),
                    ),
                  ),
                ))
              ]),
        ));
  }
}
