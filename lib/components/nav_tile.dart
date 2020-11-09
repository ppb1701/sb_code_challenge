import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavTile extends StatelessWidget {
  final Function onTap;
  final String text;
  NavTile({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 3.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 8.0,
              color: Color.fromARGB(125, 0, 0, 255),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}