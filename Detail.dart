import 'package:flutter/material.dart';

class Detail extends StatelessWidget {

  final ListWords listWordsDetail;

  Detail({Key key, @required this.listWordsDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: const Text('Detail', style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(listWordsDetail.listTitle +' (on detail page)'),
              Text(listWordsDetail.listDef),
            ],
          ),
        )
    );
  }
}
List<ListWords>  listWords = [

];

class ListWords {
  String listTitle;
  String listDef;

  ListWords(String listTitle, String listDef) {
    this.listTitle = listTitle;
    this.listDef = listDef;
  }
}