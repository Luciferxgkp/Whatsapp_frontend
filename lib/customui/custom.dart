import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/pages/individualPages.dart';
class CustomCard extends StatelessWidget {
  const CustomCard({Key key,this.chatModel,this.sourcechat}):super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualPage(chatModel: chatModel,sourcechat: sourcechat,)));
      } ,
      child: Column(
     children: [
        ListTile(
      leading: CircleAvatar(
        radius:30.0 ,
        child: SvgPicture.asset(
          chatModel.isGroup?"assets/groups.svg":"assets/person.svg",
          color:Colors.white,
          height: 37,
          width: 37,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      title: Text(chatModel.name,style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),),
      subtitle:Row(
        children: [
          Icon(Icons.done_all),
          SizedBox(width:3),
          Text(chatModel.currentMessage,style: TextStyle(
        fontSize: 13
      ),)
        ],
      ) ,
      trailing: Text(chatModel.time),
    ),
      Padding(
        padding: EdgeInsets.only(right:20,left:80),
        child: Divider(thickness: 1),
      )
     ],
    ),
    );
  }
}