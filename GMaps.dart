import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMaps extends StatefulWidget {
  final Function _toggle;
  final _scaffoldKey;
  GMaps(this._toggle, this._scaffoldKey);

  @override
  _GMapsState createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {

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
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        GoogleMap(
          onTap: (argument) => this.widget._toggle(),
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
                ElevatedButton(
                  onPressed: () {
                    this.widget._scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Icon(Icons.settings_applications_sharp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}