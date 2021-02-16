import 'package:flutter/material.dart';
import 'CustomListTile.dart';
import 'BottomNav.dart';
import 'GMaps.dart';


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
  bool _visible = true;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          GMaps(_toggle),
        ],
      ),
      endDrawer: SizedBox(
        width: 175.0,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              CustomListTile(Icons.favorite_outline_sharp, 'Favorites', ()=>{}),
              CustomListTile(Icons.sports_handball_sharp, 'Dominant Hand', ()=>{}),
              CustomListTile(Icons.house_siding_sharp, 'Campsites Only', ()=>{}),
              CustomListTile(Icons.explore_outlined, 'Discover', ()=>{}),
              CustomListTile(Icons.people_outline_sharp, 'About Us', ()=>{}),
              CustomListTile(Icons.live_help_sharp, 'Help', ()=>{}),
              CustomListTile(Icons.article_sharp , 'Campsite Data', ()=>{}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNav(context, _visible, _scaffoldKey),
    );
  }
}
