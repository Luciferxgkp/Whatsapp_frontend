import 'package:flutter/material.dart';

class ChatSetting extends StatefulWidget {
  @override
  _ChatSettingState createState() => _ChatSettingState();
}

class _ChatSettingState extends State<ChatSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Text("Chat Setting"),
      ) ,
    );
  }
}