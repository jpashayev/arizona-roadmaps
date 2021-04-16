import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Favorites extends StatelessWidget{
  String favName;
  Favorites({this.favName});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Favorites',
          ),
        ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        padding: const EdgeInsets.all(32),
        child: Text(
          favName,
          style: TextStyle(
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }
}
