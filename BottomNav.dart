import 'package:app_one/SearchPage.dart';
import 'package:app_one/ThirdPage.dart';
import 'package:flutter/material.dart';
import 'Detail.dart';
import 'dart:core';

Widget bottomNav(BuildContext context, bool _visible, final _scaffoldKey) {
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
          icon: Icon(Icons.search, color: Colors.green),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch(listWords));

            MaterialPageRoute(builder: (context) => SearchPage());
          },
        ),
        IconButton(
          icon: Icon(Icons.account_box_outlined, color: Colors.grey),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdPage()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.settings_sharp, color: Colors.grey),
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ],
    ),
  );
}
