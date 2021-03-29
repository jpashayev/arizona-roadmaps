import 'dart:convert';
import 'package:flutter/material.dart';
import 'BottomNav.dart';
import 'SettingsDrawer.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'Campsite.dart';

class CampsitePage extends StatefulWidget {

  //Passed variables
  final search;
  final ValueChanged<LatLng> changeMarker;

  //CampsitePage Constructor
  CampsitePage(this.search, {this.changeMarker});


  //override and create a State of CampsitePage
  @override
  _CampsitePageState createState() => _CampsitePageState();
}

class _CampsitePageState extends State<CampsitePage> {

  //Declare & Initialize scaffoldKey to GlobalKey
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Create list of type Campsite to store all db campsites
  final List<Campsite> _sites = [];

  //future async method to return campsites from db
  Future<List<Campsite>> fetchSites() async {

    //Declare & Initialize URL
    //Get http request
    var uri = Uri.parse('https://arizona-roadmaps-default-rtdb.firebaseio.com');
    var response = await http.get(uri);


    //List of campsites
    var sites = [];

    //Check status code 200
    if (response.statusCode == 200) {

      //decode json --> import library dart:convert
      var sitesJson = json.decode(response.body);

      //for each to cycle through decoded json
      for (var site in sitesJson) {
        //add iteration to List site
        sites.add(Campsite.fromJson(site));
      }
    }

    //return List sites
    return sites;
  }


  @override
  initState() {

    //???
    super.initState();

    //fetchSite
    fetchSites().then((value) =>
      setState(() {
        _sites.addAll(value);
      })
    );
        // .catchError((error) => handleError(error));
    
  }


  //Method to send Lat/Lng to changeMarker
  getCoordinates(int index) {

    //Take current iteration and returns coordinates to new LatLng
    LatLng pos = LatLng(
        double.parse(_sites[index].latitude),
        double.parse(_sites[index].longitude));

    //Call changeMarker with new coordinates
    this.widget.changeMarker(pos);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Certified Campsites" + _sites.length.toString()),
        actions: <Widget>[
          new Container(),
        ],
      ),
      //create ListView for easy list, enable separated builder for dividers
      //use lists for length
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: _sites.length,
        itemBuilder: (BuildContext context, index) {
          return new Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpansionTile(
                  title: Text("${_sites[index].name}"),
                  trailing: Icon(Icons.add_road_outlined),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Latitude: ${_sites[index].latitude}"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text("Latitude: ${_sites[index].longitude}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        getCoordinates(index);
                        Navigator.pop(context);
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
