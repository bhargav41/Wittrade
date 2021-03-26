import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rental/Screens/Loading.dart';
import 'package:rental/models/profile.dart';
import 'package:rental/screens/home.dart';
import 'package:rental/services/profile_service.dart';

import 'Login/login_screen.dart';

class ProfileUI2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<Profile>(
          future: ProfileService().getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isOk == true) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/originals/c0/8b/15/c08b15e60170108718a77565b552fc86.jpg"),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.uhfug.com/wp-content/uploads/2020/02/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                            radius: 60.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "${snapshot.data.name}",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Student",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        elevation: 2.0,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: Text(
                              "Information",
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ))),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Contact",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "${snapshot.data.phoneNumber}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "${snapshot.data.email}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          color: Colors.pink[400],
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink[400], Colors.pink[400]]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 50.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          onPressed: () async {
                            FlutterSecureStorage storage =
                                new FlutterSecureStorage();
                            await storage.deleteAll();
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink[400], Colors.pink[400]]),
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 50.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                    child: Text(
                  'That\'s embarrasing! Something went wrong, we are looking into it.',
                  textAlign: TextAlign.center,
                ));
              }
            } else {
              return Center(child: Loading());
            }
          }),
    ));
  }
}
