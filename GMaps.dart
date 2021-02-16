import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:core';
import 'package:permission/permission.dart';

class GMaps extends StatefulWidget {
  final Function _toggle;
  final _scaffoldKey;
  GMaps(this._toggle, this._scaffoldKey);

  @override
  _GMapsState createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {

  // GoogleMapPolyline gpsPolyLine = new GoogleMapPolyline(apiKey: "AIzaSyAP7DdQ-KhPDsk1cBq7XvImwhDayrANsMo");
  Completer<GoogleMapController> _control = Completer();
  static const LatLng _head = const LatLng(34.048927, -111.093735);
  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};
  final Set<Polyline> _polelineOff = {};
  List<LatLng> coordinates = [];
  PolylinePoints polyPoints = PolylinePoints();
  Marker _lastMarker;
  LatLng _lastPosition = _head;
  MapType _mapType = MapType.normal;
  bool _toggleRouting = false;
  bool _rushHour, _morningRushHour, _eveningRushHour;



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

  _onRoutingButtonPressed() {
    setState(() {
      _toggleRouting = !_toggleRouting;
    });
  }


  _onMarkerButtonPressed() {
    setState(() {
      if(_marker.length > 1)
        _marker.remove(_lastMarker);
      _marker.add(
          _lastMarker = Marker(
            markerId: MarkerId(_lastPosition.toString()),
            position: _lastPosition,
            infoWindow: InfoWindow(title: 'Marker Title', snippet: 'snippet'),
            icon: BitmapDescriptor.defaultMarker,
            draggable: true,
          ));
      _getPolyline();
    });
  }

  bool _getRushHour() {
    var getTime = new DateTime.now();
    if (getTime.hour >= 6 && getTime.hour <= 9) {
      _morningRushHour = true;
    }
    if (getTime.hour >= 3 && getTime.hour <= 7) {
      _eveningRushHour = true;
    }
    if (_morningRushHour || _eveningRushHour) {
      _rushHour = true;
    }
    return _rushHour;
  }

  _addPolyline() {
    PolylineId id = PolylineId("poly");
    _polyline.add(
        Polyline(
            polylineId: id,
            color: Colors.red,
            width: 4,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap,
            points: coordinates));

    setState(() {});
  }

  _getPolyline() async {
    var rushHour = _getRushHour();
    PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
      "AIzaSyAP7DdQ-KhPDsk1cBq7XvImwhDayrANsMo",
      PointLatLng(
          _marker.first.position.latitude, _marker.first.position.longitude),
      PointLatLng(
          _marker.last.position.latitude, _marker.last.position.longitude),
      avoidHighways: rushHour,
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      if (coordinates.isNotEmpty)
        coordinates.clear();
      result.points.forEach((PointLatLng point) {
        coordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyline();
    rushHour = false;
  }

  Future<void> _goToPosition() async {
    var permissionAlways = false;
    if (permissionAlways) {
      final GoogleMapController controller = await _control.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(posOne));
    }
    else {
      var permissions = await Permission.getPermissionsStatus([PermissionName.Location]);
      if (permissions[0].permissionStatus == PermissionStatus.always) {
        permissionAlways = true;
      }
      if (permissions[0].permissionStatus == PermissionStatus.allow) {
        final GoogleMapController controller = await _control.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(posOne));
      }
    }
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

  // getAddress() async {}


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        SafeArea(
          bottom: false,
          child: GoogleMap(
            onTap: (argument) => this.widget._toggle(),
            zoomControlsEnabled: false,
            compassEnabled: true,
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: true,
            onMapCreated: _mapCreated,
            initialCameraPosition: CameraPosition(
              target: _head,
              zoom: 7.0,
              tilt: 2.5,
            ),
            polylines: _toggleRouting ? _polyline : _polelineOff,
            mapType: _mapType,
            markers: _marker,
            onCameraMove: _cameraMove,
          ),),
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            right: false,
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
                  // onLongPress: () {
                  //  coordinates.clear();
                  // },
                  child: Icon(
                      Icons.post_add
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _goToPosition();
                  },
                  child: Icon(Icons.my_location),
                ),
                ElevatedButton(
                  onPressed: () {
                    _onRoutingButtonPressed();
                  },
                  child: Icon(Icons.alt_route),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     this.widget._scaffoldKey.currentState.openEndDrawer();
                //   },
                //   child: Icon(Icons.settings_applications_sharp),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}