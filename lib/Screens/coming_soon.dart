import 'package:flutter/material.dart';

class Coming_Soon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/abcd.jpg"),
        ),
      ),
    );
  }
}
