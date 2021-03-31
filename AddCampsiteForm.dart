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
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddCampsiteForm(addCampsiteForm: _addCampsiteForm);
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
    );
  }
}

class AddCampsiteForm extends StatefulWidget {
  final ValueChanged<String> addCampsiteForm;

  AddCampsiteForm({this.addCampsiteForm});

  @override
  _AddCampsiteFormState createState() => _AddCampsiteFormState();
}

class _AddCampsiteFormState extends State<AddCampsiteForm> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  final campNameController = TextEditingController();
  final addressController = TextEditingController();

  _addToDatabase() {
	setState(() {
	  databaseReference.child(8).set({
		"Name": campNameController.text,
		"Address": addressController.text,
	  });
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Campsite address",
                      hintText: "e.g. 1234 N 99th Ave",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter address";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("or"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Use Current Location"),
                    onPressed: () {
                      setState(() {
                        textController.text = "User's current location here";
                      });
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
                      if (_formKey.currentState.validate()) {
                        this.widget.addCampsiteForm("yo");
                        
                        addToDatabase();
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Campsite submitted!")));
                      }
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
