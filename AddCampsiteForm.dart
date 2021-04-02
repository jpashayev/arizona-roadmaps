import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _sites = [];

  _addCampsiteForm(String campsite) {
    setState(() {
      _sites.add(campsite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.green,
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
                    onPressed: () {},
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
