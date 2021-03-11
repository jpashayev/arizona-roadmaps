import 'package:flutter/material.dart';
import 'CustomListTile.dart';

class SettingsDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CustomListTile(Icons.favorite_outline_sharp, 'Favorites', () => {}),
          CustomListTile(Icons.sports_handball_sharp, 'Dominant Hand', () => {}),
          CustomListTile(Icons.house_siding_sharp, 'Campsites Only', () => {}),
          CustomListTile(Icons.explore_outlined, 'Discover', () => {}),
          CustomListTile(Icons.people_outline_sharp, 'About Us', () => {}),
          CustomListTile(Icons.live_help_sharp, 'Help', () => {}),
        ],
      ),
    );
  }
}
