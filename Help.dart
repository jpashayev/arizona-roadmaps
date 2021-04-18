import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'help_items/help.dart';
import 'help_items/help_list_item.dart';

class Help_Page extends StatelessWidget {
  _buildHelpList() {
    return <HelpModal>[
      const HelpModal(
          helpName: 'Arizona RoadMap', helpDescription: 'What is the app about', helpContent: 'Arizona RoadMap is an application that is specified for campsites. '),
       const HelpModal(
           helpName: 'Campsites', helpDescription: 'How to search for campsites', helpContent: 'Use Arizona RoadMap Maps on your phone to search and explore all of the Arizona campsites.'
       'For a list of campsite, Campsites are located at the bottom navigator bar along with the search bar.'
       'Campsites direction can also be found by using the search bar by typing the name of the campsite or the address'),

      const HelpModal(
          helpName: 'Helpful Tips', helpDescription: 'How to get started with the Arizona RoadMap', helpContent: 'If you are new to the Arizona RoadMap, Here is a guide to get you started'
      '\n\n 1. Use the search Icon to search for any location in Arizona'
      '\n 2. To add a new campsite to the campsite list, you can simply press the Plus Icon at the top right corner of the campsite'
      '\n 3. You can view the information of the campsites by clicking on them.'
      '\n 4. You can get a route between your location and the campsite selected by placing a marker on you location'),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: Text('Help')),
        body: HelpList(_buildHelpList()));
  }

}

