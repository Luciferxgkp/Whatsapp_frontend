import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/customui/ContactCard.dart';
import 'package:whatsapp_clone/customui/InviteCard.dart';
import 'package:whatsapp_clone/customui/PersonalInfo.dart';
import 'package:whatsapp_clone/customui/settingCard.dart';
import 'package:whatsapp_clone/pages/AccountSetting.dart';
import 'package:whatsapp_clone/pages/ChatSetting.dart';
import 'package:whatsapp_clone/pages/HelpSetting.dart';
import 'package:whatsapp_clone/pages/NotificationSetting.dart';
import 'package:whatsapp_clone/pages/StorageSetting.dart';
import 'package:whatsapp_clone/pages/profile.dart';

class settingPage extends StatefulWidget {
  const settingPage({Key key,this.user}):super(key: key);
  final User user;
  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Settings"),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>Profile(user: widget.user)));
              },
              child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: PersonalInfoCard(user: widget.user),
              ),
            ),
          ),
          Divider(thickness: 1,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>AccountSetting()));;
            },
            child: Container(
                     child:settingCard(title: "Account",subtitle: "Privacy, security, change number",icon: Icons.account_circle),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChatSetting()));
            },
            child: Container(
              child: Center(
                child: settingCard(
                  title: "Chats",
                  subtitle: "Theme, wallpaper, chat history",
                  icon: Icons.chat
                  )
                )
              )
            ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>NotificationSetting()));
            },
            child: Container(
              child: Center(
                child: settingCard(
                  title: "Notification",
                  subtitle: "Message, group & call tones",
                  icon: Icons.notifications
                )
              )
            )
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>StorageSetting()));;
            },
            child: Container(
              child: Center(
                child: settingCard(
                  title: "Storage and data", 
                  subtitle: "Network usage ,auto-download",
                  icon:Icons.data_usage
                  )
                )
              )
             ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>HelpSetting()));
            },
            child: Container(
              child: Center(
                child: settingCard(
                  title: "Help",
                  subtitle: "Help center, contact us, privacy policy",
                  icon: Icons.help_outline_outlined
                  )
                )
              )
            ),
          Divider(thickness:1),
          InkWell(
            onTap: (){},
            child: InviteCard()),
          SizedBox(height: 20,),
          Text("from"),
          Text("GOURAV",style: TextStyle(fontSize: 16),)

        ]
      ),
    );
  }
}