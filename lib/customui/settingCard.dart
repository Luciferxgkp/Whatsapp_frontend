import 'package:flutter/material.dart';

class settingCard extends StatelessWidget {
  const settingCard({Key key,this.subtitle,this.title,this.icon}):super(key: key);
  final title;
  final subtitle;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: ListTile(
      leading:Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13
        ),
      ),
    ),
    );
  }
}