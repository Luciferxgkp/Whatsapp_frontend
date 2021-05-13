import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key key,this.contact}):super(key: key);
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
        children: [
          CircleAvatar(
            radius: 23,
            child: SvgPicture.asset("assets/person.svg",
            color: Colors.white,
            height: 30,
            width: 30,
            ),
            backgroundColor: Colors.blueGrey,
          ),
          Positioned(
            bottom: 4,
            right: 5,
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 11,
                child: Icon(Icons.clear,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
        ],
      ),
      SizedBox(height: 2,),
        Text(contact.name,
        style: TextStyle(
          fontSize: 12
        ),
        ), 
      ],
    ),
    );
  }
}