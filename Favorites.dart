import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Favorites extends StatelessWidget{


  List<String> favList;
  Favorites({this.favList});

  @override
  Widget build(BuildContext context){

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorites',
          ),
        ),

        body: ListView(
          children: [_buildList(context)],
        )
      );
    }

    Widget _buildList(BuildContext context){
        for(String s in favList){
          return new Card(
            margin: EdgeInsets.all(6.0),
            color: Colors.green,
            child: ListTile(
                title: Text("Campsite: " + s,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                )
            )
          );
        }
    }
