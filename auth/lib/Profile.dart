import 'package:Liveasy/MobileNumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

enum SingingCharacter { lafayette, jefferson }

class _ProfileState extends State<Profile> {
  SingingCharacter _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HOME '),
          //centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MobileNumber()),
                    (route) => false);
              },
            ),
          ],
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
                  "Please select your Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ListTile(
                  title: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipper",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet,\n consectetur adipiscing",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            SizedBox(
                              width: 40.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.lafayette,
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ListTile(
                  title: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transporter",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet,\n consectetur adipiscing",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            SizedBox(
                              width: 40.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.jefferson,
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Container(
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
              )
            ]));
  }
}
