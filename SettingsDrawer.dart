import 'package:flutter/material.dart';
import 'CustomListTile.dart';

class SettingsDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.green,
                  Colors.greenAccent
                ])
            ),
            child: Text('Place our app logo here'),
          ),
          CustomListTile(Icons.favorite_outline_sharp, 'Favorites', ()=>{}),
          CustomListTile(Icons.sports_handball_sharp, 'Dominant Hand', ()=>{}),
          CustomListTile(Icons.people_outline_sharp, 'About Us', ()=>{}),
          CustomListTile(Icons.live_help_sharp, 'Help', ()=>{}),
        ],
      ),
    );
  }
}
