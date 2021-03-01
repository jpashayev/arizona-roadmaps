import 'package:flutter/material.dart';

class CampsitePage extends StatelessWidget {
  @override
  final List<String> campName = <String>[
    'Fossil Creek',
    'Camp Verde Hot Springs',
    'Rim Road',
    'Lake Mead - Bullhead City',
    'Highway 89A'
  ];
  final List<String> tempLocation = <String>[
    'Sedona',
    'Sedona',
    'Coconino',
    'Bullhead City',
    'Flagstaff'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placeholder"),
      ),

      //create ListView for easy list, enable separated builder for dividers
      //use lists for length
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: campName.length,
        itemBuilder: (BuildContext context, index) {
          return new Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExpansionTile(
                  title: Text('${campName[index]}'),
                  trailing: Icon(Icons.add_road_outlined),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text('${tempLocation[index]}'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
