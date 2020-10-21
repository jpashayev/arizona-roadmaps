import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  int _selectedIndex = 0;
  bool _visible = true;
  
  Completer<GoogleMapController> _control = Completer();
  static const LatLng _head = const LatLng(44, -109);
  final Set<Marker> _marker = {};
  LatLng _lastPosition = _head;
  MapType _mapType = MapType.normal;

  _mapCreated(GoogleMapController controller) {
    _control.complete(controller);
  }

  _cameraMove(CameraPosition position) {
    _lastPosition = position.target;
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
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          GoogleMap(
            onMapCreated: _mapCreated,
            initialCameraPosition: CameraPosition(
              target: _head,
              zoom: 10.0,
              tilt: 0.0,
            ),
            mapType: _mapType,
            markers: _marker,
            onCameraMove: _cameraMove,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _toggle();
              },
              child: Text("Yo"),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: _visible ? 2.0 : -30.0,
            right: 2.0,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: SizedBox(
        width: 175.0,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            height: _visible ? 45.0 : 0,
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.25, color: Colors.black),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person, color: Colors.green),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
