import 'package:flutter/material.dart';

import 'help.dart';
import 'help_page_detailed.dart';

class HelpList extends StatelessWidget {
  final List<HelpModal> _helpModal;

  HelpList(this._helpModal);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: _buildHelpList(),
    );
  }

  List<HelpListItem> _buildHelpList() {
    return _helpModal
        .map((contact) => HelpListItem(contact))
        .toList();
  }
}
class HelpListItem extends StatelessWidget {
  final HelpModal _helpModal;

  HelpListItem(this._helpModal);
  getItemAndNavigate(String item, String content, String subTitle, BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HelpDetailScreen(itemHolder : item, content: content, subTitle: subTitle)
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(child: Text(_helpModal.helpName[0])),
        title: Text(_helpModal.helpName),
        subtitle: Text(_helpModal.helpDescription),
        onTap: ()=>{
          getItemAndNavigate(_helpModal.helpName, _helpModal.helpContent, _helpModal.helpDescription, context)
        }
    );
  }
}