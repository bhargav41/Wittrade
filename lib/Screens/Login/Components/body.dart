import 'package:flutter/material.dart';
import 'package:rental/Screens/Login/components/background.dart';
import 'package:rental/Screens/Signup/signup_screen.dart';
import 'package:rental/Components/already_have_an_account_acheck.dart';
import 'package:rental/components/rounded_button.dart';
import 'package:rental/components/rounded_input_field.dart';
import 'package:rental/components/rounded_password_field.dart';
import 'package:rental/Screens/ProductScreen/home/Home_Screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental/services/auth_service.dart';

import '../../Loading.dart';
import '../../home.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _password = TextEditingController();

  final _email = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
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
                    text: "LOGIN",
                    press: () async {
                      if (_password.text != null && _email.text != null) {
                        setState(() {
                          _isLoading = true;
                        });
                        int statusCode = await AuthService().login(
                            password: _password.text, email: _email.text);
                        if (statusCode == 200) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Oops! Something went wrong'),
                          ));
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('One or more fields are empty')));
                      }
                    }),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            _isLoading == true
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[200].withOpacity(0.2),
                    ),
                    child: Center(child: Loading()),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
