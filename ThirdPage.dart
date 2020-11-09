import 'package:app_one/SearchPage.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placeholder"),
      ),
      bottomNavigationBar: Container(
        height: 45.0,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.25, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
