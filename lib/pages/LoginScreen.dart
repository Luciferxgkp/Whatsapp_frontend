import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/customui/ButtonCard.dart';
import 'package:whatsapp_clone/screens/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key,this.user}):super(key: key);
  final User user;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel sourcechat;
  List<ChatModel> chatmodel=[
    ChatModel(
      name:"Lucifer",
      isGroup: false,
      currentMessage: "hii everyone",
      time: "4.00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name:"Dev stack",
      isGroup: false,
      currentMessage: "hii Dev stack",
      time: "10.00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name:"Gourav",
      isGroup: false,
      currentMessage: "hii gourav",
      time: "13.00",
      icon: "person.svg",
      id: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodel.length,
        itemBuilder: (context,index)=>InkWell(
          onTap:() {
            sourcechat=chatmodel.removeAt(index);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Homescreen(
              chatmodels: chatmodel,
              sourcechat: sourcechat,
              user: widget.user,
            )));
          } ,
          child: ButtonCard(name: chatmodel[index].name,icon: Icons.person,),
        ),
      ),
    );
  }
}