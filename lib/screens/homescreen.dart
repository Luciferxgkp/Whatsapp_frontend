import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/pages/CallPage.dart';
import 'package:whatsapp_clone/pages/CameraPage.dart';
import 'package:whatsapp_clone/pages/StatusPage.dart';
import 'package:whatsapp_clone/pages/chatpage.dart';
import 'package:whatsapp_clone/pages/SettingPage.dart';
import 'package:whatsapp_clone/screens/CreateGroup.dart';
import 'package:whatsapp_clone/screens/SelectContact.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key,this.chatmodels,this.sourcechat,this.user}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;
  final User user;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=TabController(length: 4, vsync: this,initialIndex: 1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Clone'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
          onSelected: (value) {
            print(value);
          }  ,
          itemBuilder: (BuildContext context){
            return [
              PopupMenuItem(
                child:InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>CreateGroup()));
                  },
                  child: Text('New group'),
                ),
                value:"New group"
              ),
              PopupMenuItem(
                child:Text('New broadcast'),
                value:"New broadcast"
              ),
              PopupMenuItem(
                child:Text('WhatsApp Web'),
                value:"WhatsApp Web"
              ),
              PopupMenuItem(
                child:Text('Starred messages'),
                value:"Starred messages"
              ),
              PopupMenuItem(
                child:InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>settingPage(user: widget.user)));
                  },
                  
                    child:Text('Settings')
                  
                  
                ),
                value:"Settings",
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon:Icon(Icons.camera_alt)
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            )
          ],
        ),
      ),
      body: TabBarView(controller: _controller,children: [
        CameraPage(),
        Chatpage(
          chatmodels: widget.chatmodels,
          sourcechat: widget.sourcechat,
        ),
        StatusPage(),
        CallPage(),
      ],),
    );
  }
}