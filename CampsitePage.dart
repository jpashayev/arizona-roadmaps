import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Campsite.dart';
import 'CampsiteRepository.dart';
import 'SettingsDrawer.dart';
import 'CampsiteForm.dart';

class CampsitePage extends StatefulWidget {
  //Passed variables
  final ValueChanged<LatLng> changeMarker;

  //CampsitePage Constructor
  CampsitePage(this.changeMarker);

  //override and create a State of CampsitePage
  @override
  _CampsitePageState createState() => _CampsitePageState();
}

//create state of CampsitePage
class _CampsitePageState extends State<CampsitePage> {
  //Declare & Initialize scaffoldKey to GlobalKey
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //create DataRepos variable
  final DataRepository repository = DataRepository();

  @override
  initState() {
    super.initState();
  }

  addCampsite(Campsite campsite)  {
    repository.addCampsite(campsite);
  }

  //Widget to build page, call campsites
  Widget build(BuildContext context) {
    return _buildCampsite(context);
  }

  //Widget to build campsites
  //Includes --> Scaffold, AppBar, StreamBuilder
  // [Remaining] button to add campsite in appbar
  Widget _buildCampsite(BuildContext context) {
    return Scaffold(
        //Global Scaffold Key
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 26.0,
                  color: Colors.amberAccent[400],
                ),
              )),
          title: Text("Campsites"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CampsiteForm(addCampsite: addCampsite);
                      });
                },
                child: Icon(
                  Icons.library_add,
                  size: 26.0,
                  color: Colors.amberAccent[400],
                ),
              ),
            ),
          ],
        ),

        //StreamBuilder for Querying Snapshots
        //return Loading Indicator if no data
        //return call to _buildList if data exists
        body: StreamBuilder<QuerySnapshot>(
            stream: repository.getStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return _buildList(context, snapshot.data.documents);
            }),
        endDrawer: SizedBox(
          width: 175.0,
          child: SettingsDrawer(),
        ));
  }

  //Widget for Building List of Campsites
  //Load context and create map of data for each doc in the collection
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.all(10.0),

      //map data for each item in list, into new list
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  //Build Each Campsite (ListItem)
  //Card --> Column --> Expansion Tile
  //Padding --> Tooltip --> Text
  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    //get campsites from snapshot
    final site = Campsite.fromSnapshot(snapshot);

    //return campsites on card
    return new Card(
      margin: EdgeInsets.all(6.0),
      color: Colors.cyanAccent[700],
      //Column
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ExpansionTile(
          title: Text("Campsite: " + site.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.assistant_direction),
          backgroundColor: Colors.amberAccent[100],
          initiallyExpanded: false,
          childrenPadding: EdgeInsets.all(8.0),
          collapsedBackgroundColor: Colors.green,
          children: [
            //Distance Tooltip
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 25.0),
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Tooltip(
                    message: 'Distance Traveled on Dirt Road',
                    child: Text(
                      "Trek: " + site.distance.toString() + " Miles",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 15.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 5,
                  indent: 5.0,
                  endIndent: 5.0,
                )),

            //Tread Depth Tooltip
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 25.0),
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Tooltip(
                    message:
                        'The recommended average Tread Depth for your vehicle',
                    padding: EdgeInsets.all(5.0),
                    child: Text("Tread Depth: " + site.treadDepth.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15.5),
                        textAlign: TextAlign.left),
                  ),
                )),
              ],
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 5,
                  indent: 5.0,
                  endIndent: 5.0,
                )),

            //Suspension Tooltip
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 25.0),
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Tooltip(
                    message:
                        'The recommended minimum suspension for your vehicle',
                    padding: EdgeInsets.all(5.0),
                    child: Text("Suspension: " + site.suspension.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 15.5),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 5,
                  indent: 5.0,
                  endIndent: 5.0,
                )),

            //Row --> Gravel Size & Gravel Quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 25.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Tooltip(
                    message: 'The average gravel size encountered on the road',
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                        "Gravel Size: \n\n" +
                            site.gravelSize.toString().toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15.5)),
                  ),
                )),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 25.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Tooltip(
                    message:
                        'The average gravel quantity encountered on the road',
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                        "Gravel Quantity: \n\n" +
                            site.gravelQuantity.toString().toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15.5)),
                  ),
                ))
              ],
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 5,
                  indent: 5.0,
                  endIndent: 5.0,
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 25.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                      "Spare: \n\n" + site.spare.toString().toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.5)),
                )),
              ],
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
                child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 5,
                  indent: 5.0,
                  endIndent: 5.0,
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 25.0),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.amber[500],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                      "Permit: \n\n" + site.permit.toString().toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.5)),
                )),
              ],
            ),

            //Create Route
            //Calls getCoordinates and pops screen --> home
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4.0, 3.0, 12.0, 3.0),
                  child: ElevatedButton(
                    onPressed: () {
                      getCoordinates(site.latlng);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.search),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  //Method to send Lat/Lng from GeoPoint to changeMarker
  getCoordinates(GeoPoint latlng) {
    //Take current iteration and returns coordinates to new LatLng
    LatLng pos = LatLng(latlng.latitude, latlng.longitude);

    //Call changeMarker with new coordinates
    this.widget.changeMarker(pos);
  }
}
