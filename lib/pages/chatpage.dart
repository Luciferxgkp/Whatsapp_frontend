import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/customui/custom.dart';
import 'package:whatsapp_clone/screens/SelectContact.dart';
class Chatpage extends StatefulWidget {
  Chatpage({Key key,this.chatmodels,this.sourcechat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectContact()));
          
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context,index)=>CustomCard(
          chatModel: widget.chatmodels[index],
          sourcechat: widget.sourcechat,
        ),
      ),
    );
  }
}