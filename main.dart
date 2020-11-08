import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_one/ThirdPage.dart';
import 'package:app_one/SecondPage.dart';
import 'package:app_one/BottomNav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Arizona RoadMap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _visible = true;

  Completer<GoogleMapController> _control = Completer();
  static const LatLng _head = const LatLng(34.048927, -111.093735);
  final Set<Marker> _marker = {};
  LatLng _lastPosition = _head;
  MapType _mapType = MapType.normal;
  static final CameraPosition posOne = CameraPosition(
      target: LatLng(33.048927, -111.093735),
      bearing: 192.111,
      tilt: 11.0,
      zoom: 10.0);

  _mapCreated(GoogleMapController controller) {
    _control.complete(controller);
  }

  _cameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _mapType =
          _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  _onMarkerButtonPressed() {
    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId(_lastPosition.toString()),
          position: _lastPosition,
          infoWindow: InfoWindow(title: 'Marker Title', snippet: 'snippet'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<void> _goToPosition() async {
    final GoogleMapController controller = await _control.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(posOne));
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blueAccent,
      child: Icon(
        icon,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          GoogleMap(
            onTap: (argument) => _toggle(),
            zoomControlsEnabled: false,
            // gestureRecognizers: GestureRecognizerFactory(
            //
            // ),
            compassEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: _mapCreated,
            initialCameraPosition: CameraPosition(
              target: _head,
              zoom: 7.0,
              tilt: 2.5,
            ),
            mapType: _mapType,
            markers: _marker,
            onCameraMove: _cameraMove,
          ),
          // GestureDetector(
          //   onTap: () {
          //     _toggle();
          //   },
          // ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 28.0,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _onMapTypeButtonPressed();
                    },
                    child: Icon(Icons.map_outlined),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _onMarkerButtonPressed();
                    },
                    child: Icon(Icons.post_add),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _goToPosition();
                    },
                    child: Icon(Icons.my_location),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Settings Page",
        onPressed: () {
          _scaffoldKey.currentState.openEndDrawer();
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.blueAccent,
        mini: true,
        child: Icon(
          Icons.settings_sharp,
        ),
      ),
      endDrawer: SizedBox(
        width: 175.0,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              /*ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),*/
              CustomListTile(Icons.help_outline_sharp, 'Help', ()=>{}),
              CustomListTile(Icons.settings_outlined, 'App Settings', ()=>{}),
              CustomListTile(Icons.redeem_sharp, 'Wishlist', ()=>{}),
         
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNav(context, _visible),
    );
  }
}

// for creating items in drawar
///////////////////
// instead if list titles above, we can now inside of a drawer
// do for example: CustomListTitle(Icons.settings, 'Settings', ()=>{})
class CustomListTile extends StatelessWidget{
  
  Function onTap;
  String text;
  IconData icon;
  
  CustomListTile(this.icon, this.text, this.onTap);
  
  @override
  Widget build(BuildContext context) {
    // TOTO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text, style: TextStyle(
                      fontSize: 16.0
                  ),),
                ),
              ],
            ),
          ],
        ),
       ),
       ),
     ),
    );
  }
}
   
              
