import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GMaps extends StatefulWidget {
  final Function _toggle;

  GMaps(this._toggle);

  @override
  _GMapsState createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {

  Completer<GoogleMapController> _control = Completer();
  static const LatLng _head = const LatLng(34.048927, -111.093735);
  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Marker lastMarker;
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
      if(_marker.length < 2) {
        _marker.add(
          lastMarker = Marker(
            markerId: MarkerId(_lastPosition.toString()),
            position: _lastPosition,
            infoWindow: InfoWindow(title: 'Marker Title', snippet: 'snippet'),
            icon: BitmapDescriptor.defaultMarker,
            draggable: true,
          ));
        _getPolyline();
      }
      else {
        _marker.remove(lastMarker);
        _marker.add(
            lastMarker = Marker(
              markerId: MarkerId(_lastPosition.toString()),
              position: _lastPosition,
              infoWindow: InfoWindow(title: 'Marker Title', snippet: 'snippet'),
              icon: BitmapDescriptor.defaultMarker,
              draggable: true,
            ));
        _getPolyline();
      }
    });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    _polyline.add(
        Polyline(
          polylineId: id,
          color:Colors.red,
          points: polylineCoordinates));
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "your API key",
        PointLatLng(_marker.first.position.latitude, _marker.first.position.longitude),
        PointLatLng(_marker.last.position.latitude, _marker.last.position.longitude),
        travelMode: TravelMode.driving,
        //wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      if(polylineCoordinates.isNotEmpty)
        polylineCoordinates.clear();
      result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
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
          polylines: _polyline,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
