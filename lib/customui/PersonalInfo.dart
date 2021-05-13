import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/user.dart';

class PersonalInfoCard extends StatefulWidget {
  const PersonalInfoCard({Key key,this.user}):super(key: key);
  final User user;
  @override
  _PersonalInfoCardState createState() => _PersonalInfoCardState();
}

class _PersonalInfoCardState extends State<PersonalInfoCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('http://192.168.43.210:3000/public/${widget.user.profilePicture}'),
      ),
      title: Text(
        widget.user.fullName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        "Sleeping",
        style: TextStyle(
          fontSize: 14
        ),
      ),
    );
  }
}