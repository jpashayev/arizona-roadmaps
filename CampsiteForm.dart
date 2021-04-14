import 'package:flutter/material.dart';
import 'Campsite.dart';

class CampsiteForm extends StatefulWidget {
  final ValueChanged<Campsite> addCampsite;

  CampsiteForm({this.addCampsite});

  @override
  _CampsiteFormState createState() => _CampsiteFormState();
}

class _CampsiteFormState extends State<CampsiteForm> {
  final _formKey = GlobalKey<FormState>();
  final campNameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final distanceController = TextEditingController();
  final treadController = TextEditingController();
  final suspensionController = TextEditingController();
  final gravelsizeController = TextEditingController();
  final gravelquanController = TextEditingController();
  final spareController = TextEditingController();
  final permitController = TextEditingController();

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
            child: Scrollbar(
          child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: campNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Campsite name*",
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
                      labelText: "Distance*",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: gravelsizeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Gravel Size",
                            hintText: "e.g. Small",
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: gravelquanController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Gravel Quantity",
                            hintText: "e.g. Moderate",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: permitController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Permit",
                            hintText: "e.g. false",
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: spareController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Spare",
                            hintText: "e.g. true",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: suspensionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Suspension",
                            hintText: "e.g. ???",
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: treadController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Tread Depth",
                            hintText: "e.g. 5+",
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      //double lat = double.parse(latController.text);
                      //double lng = double.parse(latController.text);
                      //LatLng pos = new LatLng(lat, lng);

                      Campsite campsite = new Campsite(campNameController.text,
                          distance: int.parse(distanceController.text),
                          gravelSize: gravelsizeController.text,
                          gravelQuantity: gravelquanController.text,
                          suspension: suspensionController.text,
                          treadDepth: treadController.text,
                          permit: permitController.text == 'true',
                          spare: spareController.text == 'true');

                      this.widget.addCampsite(campsite);

                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
            ),
          ),
        ],
      ),
    );
  }
}
