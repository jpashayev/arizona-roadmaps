import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'BottomNav.dart';
import 'SettingsDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Campsite.dart';
import 'campsiteRepository.dart';
import 'AddCampsiteForm.dart';

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
        title: Text("Campsites"),
        
        //TO DO --> Call to method to (addCampsite)
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddCampsiteForm(addCampsite: _addCampsite);
                    });
              },
              child: Icon(
                Icons.library_add,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),

      //StreamBuilder for Querying Snapshots
      //return Loading Indicator if no data
      //return call to buildList if data exists
      body: StreamBuilder<QuerySnapshot> (
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        }),
          endDrawer: SizedBox(
            width: 175.0,
            child: SettingsDrawer(),
          ),
          bottomNavigationBar:
              bottomNav(context, true, _scaffoldKey, "third", this.widget.search),
    );
  }

  //Widget for Building List of Campsites
  //Load context and create map of data for each doc in the collection
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {

    //get campsites from snapshot
    final site = Campsite.fromSnapshot(snapshot);

    //return campsites on card
      return new Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpansionTile(
              title: Text(site.name),
              trailing: Icon(Icons.add_road_outlined),
              children: [
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text("Latitude: " + site.latlng.latitude.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text("Latitude: " + site.latlng.longitude.toString()),
                ),
                ElevatedButton(
                  onPressed: () {
                    getCoordinates(snapshot);
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ],
        ),
      );
  }

  //Method to send Lat/Lng from GeoPoint to changeMarker
  getCoordinates(DocumentSnapshot snapshot) {

    //get campsites from snapshot
    final site = Campsite.fromSnapshot(snapshot);

    //Take current iteration and returns coordinates to new LatLng
    LatLng pos = LatLng(site.latlng.latitude, site.latlng.longitude);

    //Call changeMarker with new coordinates
    this.widget.changeMarker(pos);
  }
}
