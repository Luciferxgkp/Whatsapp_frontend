import 'package:flutter/material.dart';

class StorageSetting extends StatefulWidget {
  @override
  _StorageSettingState createState() => _StorageSettingState();
}

class _StorageSettingState extends State<StorageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Text("Storage Setting"),
      ) ,
    );
  }
}