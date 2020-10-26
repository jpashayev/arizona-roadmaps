import 'package:flutter/material.dart';
import 'package:app_one/ThirdPage.dart';


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      bottomNavigationBar: Container(
        height: 45.0,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.25, color: Colors.black),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_sharp, color: Colors.green),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.search_sharp, color: Colors.green),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person_sharp, color: Colors.green),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

