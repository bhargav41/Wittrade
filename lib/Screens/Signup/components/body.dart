import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:rental/Screens/Login/login_screen.dart';
import 'package:rental/Screens/Signup/components/background.dart';
import 'package:rental/Screens/Signup/components/or_divider.dart';
import 'package:rental/Screens/Signup/components/social_icon.dart';
import 'package:rental/Components/already_have_an_account_acheck.dart';
import 'package:rental/components/rounded_button.dart';
import 'package:rental/components/rounded_input_field.dart';
import 'package:rental/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental/services/auth_service.dart';

import '../../home.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _username = TextEditingController();

  final _password = TextEditingController();

  final _phone = TextEditingController();

  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
                hintText: "Your Full Name", controller: _username),
            RoundedInputField(
              hintText: "Your Phone Number",
              controller: _phone,
            ),
            RoundedInputField(
              hintText: "Your Email",
              controller: _email,
            ),
            RoundedInputField(
              hintText: 'Password',
              controller: _password,
              isPassword: true,
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                if (_username.text != null &&
                    _password.text != null &&
                    _phone.text != null &&
                    _email.text != null) {
                  int statusCode = await AuthService().signUp(
                      username: _username.text,
                      password: _password.text,
                      phone: _phone.text,
                      email: _email.text);
                  developer.log('Status Code : $statusCode',
                      name: 'SignUpPage');
                  if (statusCode == 200) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Oops! Something went wrong'),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('One or more fields are empty'),
                  ));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
