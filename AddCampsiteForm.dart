import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddCampsiteForm extends StatefulWidget {
  final ValueChanged<String> addCampsite;

  AddCampsiteForm({this.addCampsite});

  @override
  _AddCampsiteFormState createState() => _AddCampsiteFormState();
}

class _AddCampsiteFormState extends State<AddCampsiteForm> {
  final _formKey = GlobalKey<FormState>();
  final campNameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: campNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Campsite name",
                      hintText: "e.g. Christopher Creek",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter campsite";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: latController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Lat",
                            hintText: "e.g. 40.01",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter latitude";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: lngController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Lng",
                            hintText: "e.g. 111.01",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter longitude";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: distanceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Distance",
                      hintText: "e.g. 4",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter distance";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Submit Campsite"),
                    onPressed: () {
                      double lat = double.parse(latController.text);
                      double lng = double.parse(latController.text);
                      LatLng pos = new LatLng(lat, lng);

                      // addCampsite(new Campsite(campNameController.text, distanceController.text, pos));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
