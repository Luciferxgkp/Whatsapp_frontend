import 'package:flutter/material.dart';
class HelpSetting extends StatefulWidget {
  @override
  _HelpSettingState createState() => _HelpSettingState();
}

class _HelpSettingState extends State<HelpSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Text("Help Setting"),
      ) ,
    );
  }
}