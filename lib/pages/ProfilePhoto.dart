import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/pages/profile.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({Key key,this.user}):super(key: key);
  final User user;
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color:Colors.white)),
        title: Text("Profile Photo"),
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        color: Colors.black,
        child: Center(
          child: Image.network('http://192.168.43.210:3000/public/${widget.user.profilePicture}'))),
    );
  }
}