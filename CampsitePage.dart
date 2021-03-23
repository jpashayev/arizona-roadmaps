import 'package:flutter/material.dart';
import 'BottomNav.dart';
import 'SettingsDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class CampsitePage extends StatefulWidget {

  final search;
  final ValueChanged<LatLng> changeMarker;


  CampsitePage(this.search, {this.changeMarker});

  @override
  _CampsitePageState createState() => _CampsitePageState();
}

class _CampsitePageState extends State<CampsitePage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<double> latitude = <double>[];
  List<double> longitude = <double>[];

  List<String> name = <String>[];

  @override
  initState() {
    super.initState();
    final dbRef = FirebaseDatabase.instance.reference();
    dbRef.once().then((DataSnapshot snapshot) {
      for (int i = 0; i < 8; i++) {
        latitude.add(snapshot.value[i]["Latitude"]);
        longitude.add(snapshot.value[i]["Longitude"]);
        name.add(snapshot.value[i]["Name"]);
      }
      // print(latitude);
      // print(longitude);
      // print(name);
    });
  }
  
  getCoordinates(int index) {
    LatLng pos = LatLng(latitude[index], longitude[index]);
    this.widget.changeMarker(pos);
  }

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
        itemCount: name.length,
        itemBuilder: (BuildContext context, index) {
          return new Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpansionTile(
                  title: Text("${name[index]}"),
                  trailing: Icon(Icons.add_road_outlined),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Latitude: ${latitude[index]}"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Longitude: ${longitude[index]}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        getCoordinates(index);
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
      bottomNavigationBar: bottomNav(context, true, _scaffoldKey, "third", this.widget.search),
    );
  }
}
