import 'package:flutter/material.dart';
import 'BottomNav.dart';
import 'SettingsDrawer.dart';

class CampsitePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final tempLocation;
  final search;
  CampsitePage(this.tempLocation, this.search);

  final List<String> campName = <String>[
    'Fossil Creek',
    'Camp Verde Hot Springs',
    'Rim Road',
    'Lake Mead - Bullhead City',
    'Highway 89A'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Campsites"),
        actions: <Widget>[
          new Container(),
        ],
      ),
      //create ListView for easy list, enable separated builder for dividers
      //use lists for length
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: campName.length,
        itemBuilder: (BuildContext context, index) {
          return new Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpansionTile(
                  title: Text('${campName[index]}'),
                  trailing: Icon(Icons.add_road_outlined),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("State: ${tempLocation[index]}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        search.press();
                      },
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      endDrawer: SizedBox(
        width: 175.0,
        child: SettingsDrawer(),
      ),
      bottomNavigationBar: bottomNav(context, true, _scaffoldKey, "third", tempLocation, search),
    );
  }
}
