import 'package:flutter/material.dart';
class InviteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: ListTile(
      leading:Icon(Icons.group),
      title: Text(
        "Invite a friend",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    ),
    );
  }
}