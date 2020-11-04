import 'package:flutter/material.dart';
import 'package:app_one/SecondPage.dart';
import 'package:app_one/ThirdPage.dart';

Widget bottomNav(BuildContext context, bool _visible) {
  return AnimatedContainer(
    height: _visible ? 45.0 : 0,
    duration: Duration(milliseconds: 500),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 0.25, color: Colors.black),
      ),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.green),
          iconSize: 30.0,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.person, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            );
          },
        )
      ],
    ),
  );
}
